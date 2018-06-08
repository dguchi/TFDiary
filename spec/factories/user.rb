FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "test+#{Time.now.to_f}@example.com"}
    password 'test'
    password_confirmation 'test'
    association :contractant

    before(:create){ |user|
      # ここで認証済みでメールを送信しない設定を行う
      user.skip_confirmation_notification!
      user.skip_confirmation!
    }
  end
end