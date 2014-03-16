require 'view_helper_config'

describe SocialButtons::ViewHelper do
  include ControllerTestHelpers, SocialButtons::ViewHelper
  describe "vk like button" do
    context 'with app_id' do
      it "should require a Facebook app id" do
        expect { vkontakte_like('4138567') }.not_to raise_error
      end
       it "should require a Facebook app id" do
        expect { vkontakte_like() }.to raise_error
      end
    end

    context 'with options' do
      it "should set width using option" do
        output = vkontakte_like('4138567', :width => '400')
        output.should match(/width: '400'/)
        output.should match(/<script/)        
      end
      it "should print type" do
        output = vkontakte_like('4138567',  :type => 1 )
        output.should match(/type: "1"/)
      end
    end
  end
end
