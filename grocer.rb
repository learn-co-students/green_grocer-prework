require 'pry'

def consolidate_cart(cart)
  cart.each_with_object({}) do |item, new_hash|
    item.each do |attribute, value|
      if new_hash[attribute]
        value[:count] += 1
      else
        value[:count] = 1
        new_hash[attribute] = value
      end
    end
  end
  # #code here
  #     binding.pry
end

def apply_coupons(cart, coupons)
  hash = cart
   coupons.each do |coupon_hash|
     # add coupon to cart
     item = coupon_hash[:item]

     if !hash[item].nil? && hash[item][:count] >= coupon_hash[:num]
       temp = {"#{item} W/COUPON" => {
         :price => coupon_hash[:cost],
         :clearance => hash[item][:clearance],
         :count => 1
         }
       }

       if hash["#{item} W/COUPON"].nil?
         hash.merge!(temp)
       else
         hash["#{item} W/COUPON"][:count] += 1
         #hash["#{item} W/COUPON"][:price] += coupon_hash[:cost]
       end

       hash[item][:count] -= coupon_hash[:num]
     end
   end
   hash
 end


def apply_clearance(cart)
cart.each do |attribute, value|
    if value[:clearance] == true
      value[:price] = (value[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
 total = 0
  cart = consolidate_cart(cart)

  if cart.length == 1
    cart = apply_coupons(cart, coupons)
    cart_clearance = apply_clearance(cart)
    if cart_clearance.length > 1
      cart_clearance.each do |attribute, value|
        if value[:count] >=1
          total += (value[:price]*value[:count])
        end
      end
    else
      cart_clearance.each do |attribute, value|
        total += (value[:price]*value[:count])
      end
    end
  else
    cart = apply_coupons(cart, coupons)
    cart_clearance = apply_clearance(cart)
    cart_clearance.each do |attribute, value|
      total += (value[:price]*value[:count])
    end
  end


  if total > 100
    total = total*(0.90)
  end
  total
end
