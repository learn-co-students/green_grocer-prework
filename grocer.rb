def consolidate_cart(cart)
  # code here
  unique_cart = cart.uniq
  new_cart = {}
  unique_cart.each { |item|
    item.each { |k, atts|
      new_cart[k] = atts
      atts[:count] = cart.count(item)
    }
  }
  new_cart
end

def apply_coupons(cart, coupons)
  # code here
  new_cart = {}.merge(cart)
  cart.each { |k, atts|
    coupons.each { |coupon|
      if (coupon[:item] == k) && (coupon[:num] <= atts[:count])
        new_cart[k][:count] -= coupon[:num]
        if !new_cart["#{k} W/COUPON"]
          new_cart["#{k} W/COUPON"] = {
            price: coupon[:cost],
            clearance: atts[:clearance],
            count: 1
          }
        else
          new_cart["#{k} W/COUPON"][:count] += 1
        end
      end
    }
  }
  new_cart
end

def apply_clearance(cart)
  # code here
  new_cart = {}.merge(cart)
  cart.each { |k,v|
    if v[:clearance]
      new_cart[k][:price] = (new_cart[k][:price]*0.8).round(2)
    end
  }
  new_cart
end



def checkout(cart, coupons)
  # code here
  post_coupons = apply_coupons(consolidate_cart(cart),coupons)
  post_clearance = apply_clearance(post_coupons)
  total_cost = 0
  post_clearance.each { |k,v|
    total_cost += (v[:price] * v[:count])
  }
  total_cost <= 100 ? total_cost : total_cost*0.9
end
