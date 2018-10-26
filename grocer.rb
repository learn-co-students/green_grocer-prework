require 'pry'
cart = [{"BEETS"=>{:price=>2.5, :clearance=>false, :count=>1}}]
coupons = []


def consolidate_cart(cart)
  # code here
  new_hash = {}
  count = 0
  cart.each do |item|
    item.each do |key, value|
      if !new_hash.has_key?(key)
        new_hash[key] = value
        new_hash[key][:count] = 1
      else
        new_hash[key][:count] += 1
      end
    end
  end
  return new_hash
end

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

  cart.each do |key, value|


    if cart[key][:clearance]
      cart[key][:price]-=  ('%.2f' % (cart[key][:price]*0.20)).to_f

    end
  end

  cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  total = 0
  cart.each do |key, valuehash|
    total += (valuehash[:price]*valuehash[:count])
  end

  if total > 100
    total -= total*0.1
  end
  total
end
