require 'active_record_lite'

describe "associatable" do
  before(:all) do
    # https://tomafro.net/2010/01/tip-relative-paths-with-file-expand-path
    cats_db_file_name =
      File.expand_path(File.join(File.dirname(__FILE__), "cats.db"))
    DBConnection.open(cats_db_file_name)
    class Cat < SQLObject
      set_table_name("cats")
      my_attr_accessible(:id, :name, :owner_id)

      belongs_to :human, :class_name => "Human", :primary_key => :id, :foreign_key => :owner_id
      has_one_through :house, :human, :house
    end

    class Human < SQLObject
      set_table_name("humans")
      my_attr_accessible(:id, :fname, :lname, :house_id)

      has_many :cats, :foreign_key => :owner_id
      belongs_to :house
    end

    class House < SQLObject
      set_table_name("houses")
      my_attr_accessible(:id, :address, :house_id)
    end

    # # Write your own tests as you need!
    cat = Cat.find(1)
    # p cat
    # p cat.human

    human = Human.find(1)
    # p human.cats
    # p human.house

    # p cat.house
  end


  describe "#belongs_to" do
    it "adds association as method" do
      cat.methods.should include(:human)
      human.methods.should include(:house)
    end

    it "adds an association that returns correct type" do
      cat.human.should be_instance_of(Human)
      human.house.methods.should be_instance_of(House)
    end
  end

  describe "#has_many" do
    it "association as method" do
      human.methods.should include(:cats)
    end

    it "adds an association that returns correct type" do
      human.cats.first.should be_instance_of(Cat)
    end
  end
end








