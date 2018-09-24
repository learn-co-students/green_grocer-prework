cart = {
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
  "KALE" => {:price => 3.0, :clearance => true, :count => 3},
}
coupons = [{:item => "AVOCADO", :num => 2, :cost => 5.0}]

def consolidate_cart(cart)
  # code here
  new_hash = {}
  count = 1
  cart.each do |item|
    item.each do |key, value|
      if !new_hash.has_key?(key)
        new_hash[key] = value
        new_hash[key][:count] = count
      else
        new_hash[key][:count] = count+1
      end
    end
  end
  return new_hash
end

require 'pry'

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      
      
      if cart["#{name} W/COUPON"] 
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:price => coupon[:cost], 
        :clearance => cart[name][:clearance], :count => 1 }
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end




def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
