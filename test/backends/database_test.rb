require File.join( File.dirname(__FILE__), '..', 'test_helper' )
require 'globalize/backend/database'
require 'globalize/translation'

class DatabaseTest < ActiveSupport::TestCase
  def setup
    reset_db!
    I18n.backend = Globalize::Backend::Database.new
    translations = { :en => { :foo => "Foo" } }
    
    translations.each do |locale, data|
      I18n.backend.store_translations locale, data
    end
  end

  test "should create translations" do
    I18n.backend.store_translations :en, { :hello => "Hello" }
    assert_equal "Hello", translate(:hello)
  end
  
  test "should update translations" do
    I18n.backend.store_translations :en, { :foo => "Foo!" }
    assert_equal "Foo!", translate(:foo)
  end
  
  private
    def translate(key)
      Globalize::Backend::Database::Translation.find_by_locale_and_key(I18n.locale, key, :limit => 1).text
    end
end