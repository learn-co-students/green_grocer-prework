require "pry"
def consolidate_cart(cart)
  hash = {}
  cart.each{|element|
    element.each{ |prod, p_hash|
      # binding.pry
      if hash[prod] == nil
        hash[prod] = p_hash
        hash[prod][:count] = 1
      else
        hash[prod][:count] += 1
      end
    }
  }
hash
end

def apply_coupons(cart, coupons)
  # code here
  array = []
  cart.each{ |prod, p_hash|
    coupons.each {|coupon|
      # binding.pry
      if prod == coupon[:item] && p_hash[:count] >= coupon[:num]
        array << prod + " W/COUPON"
        array << coupon[:cost]
        array << p_hash[:clearance]
        array << p_hash[:count] / coupon[:num]
        p_hash[:count] = p_hash[:count] % coupon[:num]
        # new_prod = prod + " W/COUPON"
        # cart[new_prod] = {price: coupon[:cost], clearance: p_hash[:clearance], count: p_hash[:count] / coupon[:num]}
      end
    }
  }
  until array == []
    cart[array[0]] = {price: array[1], clearance: array[2], count: array[3]}
    array.shift(4)
  end
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
