require 'active_record_lite'

class MyMassObject < MassObject
  my_attr_accessible(:x, :y)
end

# Write your own tests as you need!
obj = MyMassObject.new(:x => :x_val, :y => :y_val)
p obj

# Use these if you like.
describe MassObject do
  subject(:obj) { MyMassObject.new(:x => :x_val, :y => :y_val) }
  it "#my_attr_accessible should add #x and #y" do
    obj.methods.should include(:x)
    obj.methods.should include(:y)
  end

  it "#initialize should take a hash and properly assign values" do
    obj.x.should == :x_val
    obj.y.should == :y_val
  end
end