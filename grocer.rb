require 'pry'

def consolidate_cart(cart)

  hash_cart = {}
  list = []
  count = {}

  cart.each {|items|
    items.each {|item, details|
      if list.include?(item)
        count[item] += 1
      else
        hash_cart[item] = details
        count[item] = 1
        list << item
      end
    }
  }
  hash_cart.each {|item, details|
    details[:count] = count[item]
  }
  hash_cart
end

def apply_coupons(cart, coupons)
  coupons.each {|coupon|
    coupon_name = coupon[:item]
    if cart[coupon_name] && coupon[:num] <= cart[coupon_name][:count]
      if cart[coupon_name += " W/COUPON"]
        cart[coupon_name][:count] += 1
      else
      cart[coupon_name] = {
        price: coupon[:cost],
        clearance: cart[coupon[:item]][:clearance],
        count: 1
        }
      end
      cart[coupon[:item]][:count] -= coupon[:num]
    end
  }
  cart
end

def apply_clearance(cart)
  cart.each {|item, details|
    if details[:clearance] == true
      details[:price] = (details[:price] * 0.8).round(1)
    end
  }
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(new_cart, coupons)
  clear_cart = apply_clearance(couponed_cart)

  sum = 0
  clear_cart.each {|item, details|
    sum += details[:price]*details[:count]
  }
  if sum > 100
    sum = sum * 0.9
  end
  sum

end
