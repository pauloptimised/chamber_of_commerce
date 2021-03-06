require "rails_helper"

RSpec.describe Member, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:company_name) }
    #it { should validate_presence_of(:address) }
    #it { should validate_presence_of(:telephone) }
    #it { should validate_presence_of(:nature_of_business) }
  end

  describe "associations", :association do
    it { should have_one(:member_login) }
    it { should have_many(:member_offers) }
    it { should have_many(:member_industries).dependent(:destroy) }
    it { should have_many(:industries).through(:member_industries) }
  end
end
