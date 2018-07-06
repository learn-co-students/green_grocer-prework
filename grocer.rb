def consolidate_cart(cart)
  new_cart = {}

  cart.each do |item|

    item.each do |name, info|
      if new_cart.keys.include?(name)
        new_cart[name][:count] += 1
      else
        new_cart[name] = info.merge({count: 1})
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  items = cart.keys
  cart_with_coupons = cart

  if coupons.size > 0
    coupons.each_with_index do |groceries, index|

      groceries.values.each do |i|
        if items.include?(i)
          if coupons[index][:num] <= cart[i][:count]
            if coupons[index][:num] % cart[i][:count] == 0
              cart_with_coupons["#{i} W/COUPON"] = {
                price: coupons[index][:cost],
                clearance: cart[i][:clearance],
                count: (cart[i][:count] / coupons[index][:num])
              }
              cart_with_coupons[i] = cart[i]
              cart_with_coupons[i][:count] = (cart[i][:count] % coupons[index][:num])

            else
              cart_with_coupons["#{i} W/COUPON"] = {
                price: coupons[index][:cost],
                clearance: cart[i][:clearance],
                count: (cart[i][:count] / coupons[index][:num])
              }
              cart_with_coupons[i] = cart[i]
              cart_with_coupons[i][:count] = (cart[i][:count] % coupons[index][:num])
            end
          end
        else
          next
        end
      end
    end
  else
    cart_with_coupons = cart
  end
  cart_with_coupons
end

def apply_clearance(cart)
  cart_with_clearance = cart

  cart.each do |item, info|
    if cart[item][:clearance]
      cart_with_clearance[item][:price] = (cart[item][:price] * 0.8).round(2)
    else
      next
    end
  end
end

def checkout(cart, coupons)
  total_price = 0

  consolidated = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated, coupons)
  clearance_applied = apply_clearance(coupons_applied)

  clearance_applied.each do |item, info|
    total_price += (clearance_applied[item][:price] * clearance_applied[item][:count])
  end

  if total_price >= 100
    total_price = (total_price * 0.9).round(2)
  end
  total_price
end
