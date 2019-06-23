require 'pry'

def sample_cart
{
  "PEANUTBUTTER" => {:price => 3.00, :clearance => true, :count => 2},
  "KALE" => {:price => 3.00, :clearance => false, :count => 3},
  "SOY MILK" => {:price => 4.50, :clearance => true, :count => 1}
}
end 

def consolidate_cart(cart)
  count_hash = cart.each_with_object(Hash.new(0)) { |item, counts| counts[item] += 1 }
  consolidated_hash = {}
  count_hash.each do |k, v| 
    k.each do |item_key, value_hash|
      consolidated_hash[item_key] ||= value_hash
      value_hash[:count] = v
    end
  end 
  consolidated_hash
end


def apply_coupons(cart, coupons)
  cart_hash = cart 
  coupons.each do |coupon|
    item = coupon[:item]
    if cart_hash[item] != nil && cart_hash[item][:count] >= coupon[:num]
      joined = {
        "#{item} W/COUPON" => {:price => coupon[:cost], :clearance => cart_hash[item][:clearance], :count => 1}
      }
      if cart_hash["#{item} W/COUPON"] == nil 
        cart_hash.merge!(joined)
      else 
        cart_hash["#{item} W/COUPON"][:count] += 1
      end 
      cart_hash[item][:count] -= coupon[:num]
    end 
  end 
  cart_hash
end

def apply_clearance(cart)
  grocery_cart = cart 
  grocery_cart.each do |item, value_hash|
    if value_hash[:clearance]
      value_hash[:price] -= ((value_hash[:price]) * 0.2)
      end 
  end 
end


def checkout(cart, coupons)
  concart = consolidate_cart(cart)
  coupcart = apply_coupons(concart, coupons)
  clearcart = apply_clearance(coupcart)
  total = 0
  clearcart.each do |item, value_hash|
    total += (value_hash[:price] * value_hash[:count])
  end 
  if total > 100 
    total -= (total * 0.1)
  end 
  total 
end
