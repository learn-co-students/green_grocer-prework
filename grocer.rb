def consolidate_cart(cart)
  new_hash = {}
  cart.each{|ele|
    ele.each{|item, values|
    if new_hash[item] == nil
      new_hash[item] = {}
      new_hash[item] = values
      new_hash[item][:count] = 1
    else
      new_hash[item][:count] += 1
    end
    }
  }
  new_hash      
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
