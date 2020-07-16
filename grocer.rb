require 'pry'


###########################

def consolidate_cart(cart)
  # code here
  new_hash = { }

  cart.each do |hash|
    hash.each do |veg, details_hash|
      if new_hash[veg].nil?
        new_hash[veg] = details_hash.merge({:count => 1})
    	else
      new_hash[veg][:count] += 1
      end
    end
  end
  new_hash
end



def apply_coupons(cart, coupons)
  # code here
  result = {}
  cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] = info[:count] - coupon[:num]
        if result["#{food} W/COUPON"]
          result["#{food} W/COUPON"][:count] += 1
        else
          result["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
    result[food] = info
  end
  result
end


#Question 3: The apply_clearance method
def apply_clearance(cart)
  # code here
  cart.each do |item, hash|
    discount = cart[item][:clearance]
    if item && discount
      new_price = cart[item][:price] - (cart[item][:price] * 0.2)
      cart[item][:price] = new_price
    else
      cart
    end
  end
end


def checkout(cart, coupons)

  cart = consolidate_cart(cart)
  total = 0

  if cart.length == 1
    cart = apply_coupons(cart, coupons)
    cart2 = apply_clearance(cart)
    if cart.size > 2
      cart2.each do |item, hash|
        total += hash[:price] * hash[:count]
      end
    else
      cart2.each do |item, hash|
        total += hash[:price] * hash[:count]
      end
    end
  else
    cart = apply_coupons(cart, coupons)
    cart2 = apply_clearance(cart)
    cart2.each do |item, hash|
      total += hash[:price] * hash[:count]
    end
  end

  total > 100 ? total * 0.9 : total

end