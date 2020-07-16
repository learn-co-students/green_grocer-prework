def consolidate_cart(cart)
  output = {}
  cart.each do |food|
    food.each do |item, details|
      if output.include?(item)
        output[item][:count] += 1
      else
        output[item] = details
        output[item][:count] = 1
      end
    end
  end
  output
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart.include?(item)
      coupon_quantity = coupon[:num]
      cart_quantity = cart[item][:count]
      if coupon_quantity <= cart_quantity
        item_with_coupon = item + " W/COUPON"
        cart[item_with_coupon] = {}

        cart[item].each do |key, value|
          cart[item_with_coupon][key] = value
        end

        cart[item_with_coupon][:price] = coupon[:cost]
        cart[item_with_coupon][:count] = cart_quantity / coupon_quantity
        cart[item][:count] = cart_quantity % coupon_quantity
      end
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |item, att|
    if att[:clearance]
      att[:price] = (att[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  checkout_cart = consolidate_cart(cart)
  checkout_cart = apply_coupons(checkout_cart, coupons)
  checkout_cart = apply_clearance(checkout_cart)
  total = 0
  checkout_cart.each do |grocery, attribute|
    total += (attribute[:price] * attribute[:count]).round(2)
  end
  if total > 100.00
    (total * 0.9).round(2)
  else
    total
  end
end
