require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'ニックネーム、メールアドレス、パスワード、お名前の「姓」「名」（カタカナ含む）、生年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'メールアドレスは重複していないければ登録できる' do
        @user.save
        another_user = FactoryBot.build(:user)
        expect(another_user).to be_valid
      end
      it 'メールアドレスは、@を含むと登録できる' do
        @user.email = 'test@test'
        expect(@user).to be_valid
      end
      it 'パスワードは、6文字以上、半角英数字混合でパスワードとパスワード（確認）が一致すれば登録できる' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
    it 'ニックネームは、空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'メールアドレスは、空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it 'メールアドレスは、@を含まないと登録できない' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it 'パスワードは、空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは、6文字未満では登録できない' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it '英字のみのパスワードでは登録できない' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
    end
    it '数字のみのパスワードでは登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
    end
    it '全角文字を含むパスワードでは登録できない' do
      @user.password = 'ｋｋｋｋｋｋ' # 全角の文字を設定
      @user.password_confirmation = 'ｋｋｋｋｋｋ' # 全角の文字を設定
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
    end
    it 'パスワードとパスワード（確認）が不一致では登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
   end
  end

  describe '本人情報確認' do
    context '新規登録できるとき' do
      it 'お名前「姓」は、全角であれば登録できる' do
        @user.first_name = '山田'
        expect(@user).to be_valid
      end
      it 'お名前「名」は、全角であれば登録できる' do
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end
      it 'お名前カナ「姓」は、全角カタカナであれば登録できる' do
        @user.first_name = 'ヤマダ'
        expect(@user).to be_valid
      end
      it 'お名前カナ「名」は、全角カタカナであれば登録できる' do
        @user.last_name = 'ヤマダ'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
    it 'お名前の「姓」(全角)は、空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'お名前の「名」(全角)は、空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'お名前の「姓」(全角)は、全角（漢字・ひらがな・カタカナ）での入力がないと登録できない' do
      @user.first_name = 'John' # 半角の名前を設定
      @user.valid?
      expect(@user.errors.full_messages).to include("First name  is invalid. Input full-width characters")
    end
    it 'お名前の「名」(全角)は、全角（漢字・ひらがな・カタカナ）での入力がないと登録できない' do
      @user.last_name = 'Smith' # 半角の名字を設定
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name  is invalid. Input full-width characters")
    end
    it 'お名前カナの「姓」(全角)は、空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it 'お名前カナの「名」(全角)は、空では登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it 'お名前カナの「姓」(全角)は、全角（カタカナ）での入力がないと登録できない' do
      @user.first_name_kana = 'たろう' # ひらがなを含む名前カナを設定
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana  is invalid. Input full-width katakana characters")
    end
    it 'お名前カナの「名」(全角)は、全角（カタカナ）での入力がないと登録できない' do
      @user.last_name_kana = 'すみす' # ひらがなを含む名字カナを設定
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana  is invalid. Input full-width katakana characters")
    end
    it '生年月日は、空では登録できない' do
      @user.birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
   end
  end
end
