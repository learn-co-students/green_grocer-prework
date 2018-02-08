def consolidate_cart(cart)
  consolidatedCart = {}
  cart.each {|inventory|
    inventory.each {|item, values|
      if consolidatedCart[item]
        consolidatedCart[item][:count] += 1
      else
        consolidatedCart[item] = values
        consolidatedCart[item][:count] = 1
      end
    }
  }
  consolidatedCart
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
