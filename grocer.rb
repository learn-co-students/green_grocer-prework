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
  cart.each{ |prod, p_hash|
    binding.pry
    if prod == coupons[:item] && p_hash[:count] >= coupons[:num]
      p_hash[:count] = p_hash[:count] % coupons[:num]
      new_prod = prod + " W/COUPON"
      cart[new_prod] = {price: coupons[:cost], clearance: p_hash[:clearance], count: p_hash[:count] / coupons[:num]}
    end
  }
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
