def consolidate_cart(cart)
  groceries_updated = {}
  cart.each do |full_item|
    if groceries_updated[full_item.keys[0]] == nil
      groceries_updated[full_item.keys[0]] = full_item.values[0].dup
      groceries_updated[full_item.keys[0]][:count] = 1
    else
      groceries_updated[full_item.keys[0]][:count] += 1
    end
  groceries_updated
end
  groceries_updated
end

def apply_coupons(cart, coupons)
  discount = {}
  cart.each do |food_item, detail|
    coupons.each do |coupon|
      if food_item == coupon[:item] && detail[:count] >= coupon[:num]
        detail[:count] = detail[:count] - coupon[:num]
      if discount["#{food_item} W/COUPON"]
          discount["#{food_item} W/COUPON"][:count] += 1
      else
        discount["#{food_item} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => detail[:clearance],
          :count => 1
        }
        end
      end
    end
    discount[food_item] = detail
  end
  discount
end

def apply_clearance(cart)
  cart.each do |food_item, detail|
      cart_item = cart[food_item]
      if cart_item[:clearance]
        cart_item[:price] = cart_item[:price] - (cart_item[:price] * 0.2)
      end
    end
    cart
  end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each{|food_item, detail|
    total += detail[:price] * detail[:count]
  }
  if total > 100
    total *= 0.9
  end
  total
end
