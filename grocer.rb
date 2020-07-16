require 'pry'

def consolidate_cart(cart)
  cart = cart.to_a
  consolidated = {}
  cart.each_with_index { |item, idx|
    cart[idx].each { |food, data|
      if consolidated[food]
        consolidated[food][:count] += 1
      else
        consolidated[food] = data
        consolidated[food][:count] = 1
      end
    }
  }
  consolidated
end

def apply_coupons(cart, coupons=nil)

  if coupons
    coupons.each { |food|
      coupon_name = food[:item]
      if cart[coupon_name]
          num_in_cart = cart[coupon_name][:count]
          if num_in_cart >= food[:num]
            num_in_cart -= food[:num]
            cart[coupon_name][:count] = num_in_cart

            if cart["#{food[:item]} W/COUPON"]
              cart["#{food[:item]} W/COUPON"][:count] += 1
            else
              cart["#{food[:item]} W/COUPON"] = {
                  :price => (food[:cost]),
                  :clearance => cart[coupon_name][:clearance],
                  :count => 1
                }
            end
        end  
      end
    }
  end
  cart
end

def apply_clearance(cart)
  cart.each { |food, data|
    if cart[food][:clearance]
      cart[food][:price] = (cart[food][:price] * 0.8).round(2)
    end
  }
  cart
end


def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total_price = 0
  cart.each { |food, data|
    item_total = cart[food][:count] * cart[food][:price]
    total_price += item_total
  }
  if total_price > 100.00
    total_price *= 0.9
  end
  total_price
end
