require 'test_helper'
#data here exits in the test db

class CategoryTest < ActiveSupport::TestCase

    def setup #special method that runs before each test is run
        @category = Category.new(name:"Sports")
    end

   test "category should be valid" do
       assert @category.valid? #assertions are built in rails method to test for diff cases, this one tests for true.
   end

   test "name should be present" do
       @category.name = " "
       assert_not @category.valid?
   end

   test "name should be unique" do
       @category.save
       @category2 = Category.new(name: "Sports")
       assert_not @category2.valid?
   end

   test "name should not be too long" do
       @category.name = "a" * 26
       assert_not @category.valid?
   end

   test "name should not be too short" do 
    @category.name = "aa" 
    assert_not @category.valid?
   end

end