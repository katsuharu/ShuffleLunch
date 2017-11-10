class MatchingsController < ApplicationController

  before_action :logged_in_user, :correct_user, only: [:index, :update]
  before_action :set_user, only: [:index, :update, :change]
  before_action only: :update

  entry_id = 0;    #アプリ全体値を保持し続ける。(グローバル変数orインスタンス変数?)
  pair_no = 0;
  
  def index
    entry_id++;   #その日のシャッフルランチに申し込んだ人を識別するためのID。
    
    #insert into entry entry_table.user_id = current_user.id
    @entry = Entry.create(:user_id => current_user.id, :entry_id => entry_id)
    @entry.save
    if entry_id % 3 == 0
      pari_no++;
      #update entry pair_no(entryテーブルのカラムの方) = pair_no where entry_id(entryテーブルのカラムの方) = entry_id, entry_id - 1, entry_id - 2;
      Entry.where(entry_id: entry_id, entry_id - 1, entry_id - 2).update_all(pair_no: pair_no)
      
      render :action "show " #マッチングしました。おめでとうございます画面
      #マッチング相手確認ページのURLを貼った、マッチングお知らせメールを送信(コード調べ中)
      #send email to user[:entry_id - 1], user[:entry_id - 2]
    else
      render :action "waiting" #エントリーを受け付けました。ただ今マッチング中です、お待ちください画面
    end
  end

  def update
    if flash[:danger].blank?
      render :action "show"
    else
      redirect_to :action => "index"
    end
  end

  private
    def set_user
      @user = current_user
    end

end