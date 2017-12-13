require "pry"

cart = [
{"AVOCADO" => {:price => 3.00, :clearance => true}},
{"KALE" => {:price => 3.00, :clearance => false}},
{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
{"ALMONDS" => {:price => 9.00, :clearance => false}},
{"TEMPEH" => {:price => 3.00, :clearance => true}},
{"CHEESE" => {:price => 6.50, :clearance => false}},
{"BEER" => {:price => 13.00, :clearance => false}},
{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
{"BEETS" => {:price => 2.50, :clearance => false}},
{"AVOCADO" => {:price => 3.00, :clearance => true}},
{"SOY MILK" => {:price => 4.50, :clearance => true}}
]

coupons = [
{:item => "AVOCADO", :num => 2, :cost => 5.00},
{:item => "BEER", :num => 2, :cost => 20.00},
{:item => "CHEESE", :num => 3, :cost => 15.00}
]


def consolidate_cart(array)
    count = Hash.new(0)
    array.each do |foods|
        count[foods] += 1
    end
    result = Hash.new
    count.each do |foods,count_num|
        foods.each do |food,specs|
            result[food] = specs
            result[food][:count] = count[foods]
        end
    end
    result
end


def apply_coupons(cart, coupons)
    consolidated = consolidate_cart(cart)
end



coupons.each do |coupon|
    consolidated[coupon[:item] + " W/COUPON"] = {:price => coupon[:cost], :clearance =>consolidated[coupon[:item]][:clearance], :count => consolidated[coupon[:item]][:count] - coupon[:num]}
end
consolidated



apply_coupons(cart, coupons)

#    cart.each do |items|
#        items.each do |food, specs|
#            cart_hash[food] = specs
#
#        end
#    end
#
#
#    coupons.each do |coupon|
#        cart << {coupon[:item] + " W/COUPON" => {:price => coupon[:cost], :clearance =>cart_hash[coupon[:item]][:clearance], :count => cart_hash[coupon[:item]][:count] - coupon[:num]}}
#    end
#    cart


def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
