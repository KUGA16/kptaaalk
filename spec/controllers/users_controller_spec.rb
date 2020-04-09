require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  describe "ログインしている場合" do
    login_user
end
