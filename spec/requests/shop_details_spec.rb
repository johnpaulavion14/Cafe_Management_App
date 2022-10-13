require 'rails_helper'

RSpec.describe "ShopDetails", type: :request do

  describe "#Shop_details Request" do
    it "shop details page" do
      get shop_path
      expect(response).to have_http_status(200)
    end

    it "create shop details page" do
      post create_details_path
      expect(response).to have_http_status(302)
    end
  end
end
