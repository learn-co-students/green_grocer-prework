def consolidate_cart(cart)
  # code here
  consolidated_cart = {}
  cart.each do |items|
    items.each do |name, values|
      if consolidated_cart[name] == nil
        consolidated_cart[name] = values.clone
      end
      if consolidated_cart[name][:count] == nil
        consolidated_cart[name][:count] = 1
      else
        consolidated_cart[name][:count] += 1
      end
    end
  end
  consolidated_cart
 end

def apply_coupons(cart, coupons)
  # code here
  new_cart = cart.clone
  item_values = coupons.map {|item| item.values}
  item_values.each_with_index do |selection, i|
    name = selection[0]
    if new_cart[name] != nil
      new_name = "#{name} W/COUPON"
      if new_cart[new_name] == nil
        new_cart[new_name] = new_cart[name].clone
        new_cart[new_name][:price] = coupons[i][:cost]
        new_cart[new_name][:count] = 1
      else
        new_cart[new_name][:count] += 1
      end
      if (new_cart[name][:count] -= coupons[i][:num]) < 0
        new_cart[name][:count] -= coupons[i][:num]
      end
    end
  end
  new_cart
end

def apply_clearance(cart)
  # code here
  updated_cart = cart.clone
  updated_cart.each do |item, info|
    if info[:clearance]
      info[:price] = (info[:price] * 0.80).round(1)
    end
  end
  updated_cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  coupon_hash = apply_coupons(consolidated_cart, coupons)
  initial_discount = apply_clearance(coupon_hash)
  total = 0
  initial_discount.each do |item, info|
    if info[:count] >= 0
      total += info[:price] * info[:count]
    else
      if initial_discount.include?(item + " W/COUPON")
        initial_discount[item + " W/COUPON"][:count] -= 1
        total += info[:price] 
      end
    end
  end
  if total > 100
    total = total * 0.90
  end
  total
end