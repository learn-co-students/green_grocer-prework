require 'pry'

def consolidate_cart(cart)
  consolidated_cart = Hash.new
  cart.each do |hash_item|
    hash_item.each do |item, attributes|
      if consolidated_cart[item] == nil
        consolidated_cart[item] = attributes
        consolidated_cart[item].merge!(:count => 1)
      else
        consolidated_cart[item][:count] += 1
      end
    end
  end
  consolidated_cart
end
=begin
[{"AVOCADO"=>{
  :price=>3.0,
  :clearance=>true}},
  {"AVOCADO"=>{
  :price=>3.0,
  :clearance=>true}},
  {"KALE"=>{:price=>3.0,
  :clearance=>false}}]
=end

def apply_coupons(cart, coupons)
  consolidated_cart = Hash.new
  #binding.pry
  cart.each do |item_cart, attributes_cart|
    consolidated_cart[item_cart] = attributes_cart
    coupons.each do |coupon|
        if item_cart == coupon[:item]
            if coupon[:num] <= cart[item_cart][:count]
              coupons_applied = (cart[item_cart][:count]/coupon[:num]).floor
              #attributes_coupon = attributes_cart
              cart[item_cart][:count] -= (coupons_applied*coupon[:num])
              consolidated_cart[item_cart] = attributes_cart
              consolidated_cart["#{item_cart} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[item_cart][:clearance], :count => coupons_applied}
              #attributes_cart.each {|attribute, attr_value| consolidated_cart["#{item_cart} W/COUPON"].merge!(attribute => attr_value)}
              #consolidated_cart["#{item_cart} W/COUPON"][:price] = coupon[:cost]
              #consolidated_cart["#{item_cart} W/COUPON"][:count] = coupons_applied
            end
        end
    end
  end
  consolidated_cart
  #binding.pry
end
=begin
cart
{
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 1},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1},
  "AVOCADO W/COUPON" => {:price => 5.0, :clearance => true, :count => 1},
}
coupons
{:item => "AVOCADO", :num => 2, :cost => 5.0}
=end

def apply_clearance(cart)
  cart.each {|item, attributes| cart[item][:price] = (cart[item][:price] * 0.80).round(2) if cart[item][:clearance] == true}
  cart
end
=begin
{
  "PEANUTBUTTER" => {:price => 3.00, :clearance => true,  :count => 2},
  "KALE"         => {:price => 3.00, :clearance => false, :count => 3}
  "SOY MILK"     => {:price => 4.50, :clearance => true,  :count => 1}
}
=end

def checkout(cart, coupons)
  cart_checkout = 0
  consolidated_cart = consolidate_cart(cart)
  applied_coupons_cart = apply_coupons(consolidated_cart, coupons)
  applied_clearance_cart = apply_clearance(applied_coupons_cart)
  applied_clearance_cart.each do |item, attribute|
      cart_checkout += attribute[:price]*attribute[:count]
  end
  cart_checkout > 100 ? cart_checkout * 0.90 : cart_checkout
end
