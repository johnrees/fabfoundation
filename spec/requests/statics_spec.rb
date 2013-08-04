require 'spec_helper'

describe "Statics" do
  it "disallows unauthenticated users" do
    visit static_secret_url
    expect(current_path).to eq(signin_path)
  end

  it "allows authenticated users" do
    user_signin FactoryGirl.create(:user)
    visit static_secret_url
    expect(current_path).to eq(static_secret_path)
  end
end
