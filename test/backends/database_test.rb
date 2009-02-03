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
    assert_equal "Hello", I18n.translate(:hello)
  end
  
  test "should update translations" do
    I18n.backend.store_translations :en, { :foo => "Foo!" }
    assert_equal "Foo!", I18n.translate(:foo)
  end
  
  test "returns an instance of Translation::Static" do
    translation = I18n.translate :foo
    assert_instance_of Globalize::Translation::Static, translation
  end

  test "returns error message for missing translation" do
    message = I18n.translate :foz
    assert_equal "translation missing: en, foz", message
  end
  
  test "raise exception on missing translation" do
    assert_raise I18n::MissingTranslationData do
      I18n.translate :foz, :raise => true
    end
  end
end
