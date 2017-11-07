namespace :matching do
  task :execute, ['time_zone_id'] => :environment do  | task, args |
    companies = Company.all

    companies.try(:each) do | company |
      eat_out_users = User.where(company_code: company.try(:code), status: 1, time_zone_id: args.time_zone_id, lunch_type: 0).shuffle
      bento_users = User.where(company_code: company.try(:code), status: 1, time_zone_id: args.time_zone_id, lunch_type: 1).shuffle
      adjust_matching_users eat_out_users, 0
      adjust_matching_users bento_users, 1
    end
  end

  def adjust_matching_users users, lunch_type
    count = 1
    users_array = Array.new

    # ユーザー数をマッチング最大人数(4)で割った商と余り
    calc_result = users.size.divmod(4)
    # 取得したユーザー数を配列用に数値調整
    users_count = users.size - 1
    # ループ回数上限値設定
    max_count = users_count - calc_result[1]

    (0..max_count).each do | num |
      if users[num].present?
        users[num].update status: 2
        users_array << users[num].try(:id)
        if count >= 4
          Matching.create user1_id: users_array[0], user2_id: users_array[1], user3_id: users_array[2], user4_id: users_array[3], lunch_type: lunch_type
          count = 0
          users_array = Array.new
        end
        count += 1
      end
    end

    case calc_result[1]
    when 3
      max_count = max_count += 1
      (max_count..users_count).each do | num |
        if users[num].present?
          users[num].update status: 2
          users_array << users[num].try(:id)
          if count == 3
            Matching.create user1_id: users_array[0], user2_id: users_array[1], user3_id: users_array[2], user4_id: nil, lunch_type: lunch_type
            count = 0
            users_array = Array.new
          end
          count += 1
        end
      end
    else
      max_count = max_count += 1
      (max_count..users_count).each do | num |
        users[num].update(status: 3) if users[num].present?
      end
    end
  end

  task reset: :environment do
    Message.delete_all
    Matching.delete_all
    User.all.update status: 0, time_zone_id: nil, lunch_type: nil
  end
end