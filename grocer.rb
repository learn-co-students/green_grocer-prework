require 'pry'
def consolidate_cart(cart)
  # code here
cart.each_with_object({}) do |produce_hash, list|
  produce_hash.each do |produce, attributes_hash|
    if list[produce]
    attributes_hash[:count] += 1
    else
    list[produce] = attributes_hash
    attributes_hash[:count] = 1
    end
  end
end
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] != nil
      #if cart[name] holds a value do...
    if cart[name][:count] >= coupon[:num]
      cart[name][:count] =  cart[name][:count] - coupon[:num]
      if cart["#{name} W/COUPON"].nil?
        cart["#{name} W/COUPON"] = {
        :price => coupon[:cost],
        :clearance => cart[name][:clearance],
        :count => 1
      }
    else
      cart["#{name} W/COUPON"][:count] += 1
    end
    end
    end
  end
  #if cart[name] does not hold value return
  cart
end

def apply_clearance(cart)
  cart.each do |produce, produce_hash|
    if produce_hash[:clearance] == true
    produce_hash[:price] = (produce_hash[:price] * 0.8).round(2)
  end
  end
  cart
end



def checkout(cart, coupons)
# code here	   # code here
  the_cart = consolidate_cart(cart)
  apply_coupons(the_cart, coupons)
  apply_clearance(the_cart)
  cart_total = 0
  the_cart.each do |produce, produce_hash|
    cart_total += produce_hash[:price] * produce_hash[:count]
  end
  if cart_total > 100
    cart_total = cart_total * 0.9
  end
  cart_total
end
