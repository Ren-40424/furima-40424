require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての情報が適切なら登録できる' do
        expect(@user).to be_valid
      end
    end

    describe 'ユーザー情報' do
      context '新規登録でないとき' do
        it 'ニックネームが必須であること' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end

        it 'メールアドレスが必須であること' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it 'メールアドレスが一意性であること' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end

        it 'メールアドレスは、@を含む必要があること' do
          @user.email = 'test'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end

        it 'パスワードが必須であること' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end

        it 'パスワードは、6文字以上での入力が必須であること' do
          @user.password = 'test'
          @user.password_confirmation = 'test'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end

        it 'パスワードは、半角英数字混合での入力が必須であること' do
          @user.password = 'testtest'
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end

        it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
          @user.password = 'testtest1'
          @user.password_confirmation = 'testtest2'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
      end
    end

    describe '本人情報確認' do
      context '新規登録でないとき' do
        it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
          @user.first_name = ''
          @user.last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank", "Last name can't be blank")
        end

        it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
          @user.first_name = 'test'
          @user.last_name = 'test'
          @user.valid?
          expect(@user.errors.full_messages).to include("First name is invalid", "Last name is invalid")
        end

        it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること' do
          @user.read_first_name = ''
          @user.read_last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Read first name can't be blank", "Read last name can't be blank")
        end

        it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
          @user.read_first_name = 'あ'
          @user.read_last_name = '一'
          @user.valid?
          expect(@user.errors.full_messages).to include("Read first name is invalid", "Read last name is invalid")
        end

        it '生年月日が必須であること' do
          @user.birth = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birth can't be blank")
        end
      end
    end
  end
end
