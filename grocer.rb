require "pry"


def consolidate_cart(cart)
cart_hash = {}
  cart.each do |list|
    list.each do |item, info|

      if cart_hash[item] == nil
      cart_hash[item] = info
      cart_hash[item][:count] = 1

      else cart_hash[item][:count] +=1

      end
    end
  end
cart_hash
end

def apply_coupons(cart, coupons)
  coupon_hash = {}

  cart.each do |item, details|
  coupons.each do |coupon|
    coupon_hash[item] = details
    coupon_name = "#{item} W/COUPON"
    if item == coupon[:item] && details[:count] >= coupon[:num]
        details[:count] = (details[:count] - coupon[:num])
        if coupon_hash.include?(coupon_name)
          coupon_hash[coupon_name][:count]
        else
          coupon_hash[coupon_name] = {:price => coupon[:cost], :clearance =>  details[:clearance], :count => (details[:count] / coupon[:num]) +1 }
        end
      end
    end
    coupon_hash[item] = details
  end
coupon_hash
end

def apply_clearance(cart)
  cart.each do |item, details|

    if details[:clearance] == true
      details[:price] = (details[:price] * 0.8).round(2)
    else
      details[:price] = details[:price]
    end
  end
cart
end



def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

    total = 0
  cart.each do |item, details|
    total = total + (details[:price] * details[:count])
  end
if total > 100
  total = total * 0.9

end
total
end
