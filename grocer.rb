def consolidate_cart(cart)
  new_hash = {}
  cart.each do |hash|

    hash.each do |item, info|
      info.each do |info2, answer|
        new_hash[item][info2] = answer
      end
    end
  end
  puts new_hash
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
