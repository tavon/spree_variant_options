require 'test_helper'

class Spree::OptionValueTest < ActiveSupport::TestCase

  setup do
    @images = Dir[File.expand_path("../../../support/images/*", __FILE__)]
  end

  should_have_attached_file :image
  
  context "a new option value" do
  
    setup do
      @option_value = Spree::OptionValue.new
    end
  
    should "not have an image" do
      assert !@option_value.has_image?
    end
  
  end
  
  context "an existing option value" do
  
    setup do
      @option_value = Factory.create(:option_value)
    end
  
    should "not have an image" do
      assert !@option_value.has_image?
    end
    
    context "with an image" do
      
      setup do
        @path = @images.shuffle.first
        file = File.open(@path)
        @option_value.update_attributes(:image => file)
        file.close
      end
      
      should "have an image" do
        assert @option_value.has_image?
      end
      
      should "have small large and original images" do
        dir = File.expand_path("../../../dummy/public/system/images/#{@option_value.id}", __FILE__)
        %w(small large original).each do |size|
          assert File.exists?(File.join(dir, size, File.basename(@path)))
        end        
      end
      
    end
  
  end
  
end
