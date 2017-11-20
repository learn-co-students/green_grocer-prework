def consolidate_cart(cart)
  # code here
  consolidate_cart = {}
  cart.each do |item|
    item.each do |ingredient, attributes|
      consolidate_cart[ingredient] = attributes
      consolidate_cart[ingredient][:count] = cart.count(item)
    end
  end
  consolidate_cart
end

def apply_coupons(cart, coupons)
  # code here
  new_cart = {}
  cart.each { |ingredient, attributes| new_cart[ingredient] = attributes }
  cart.each do |ingredient, attributes|
    coupons.each do |coupon|
      if (ingredient == coupon[:item]) && (coupon[:num] <= attributes[:count])
        new_cart["#{ingredient} W/COUPON"] = {}
        new_cart["#{ingredient} W/COUPON"][:price] = coupon[:cost]
        new_cart["#{ingredient} W/COUPON"][:clearance] = cart[ingredient][:clearance]
        new_cart["#{ingredient} W/COUPON"][:count] = new_cart[ingredient][:count] / coupon[:num]
        new_cart[ingredient][:count] = (new_cart[ingredient][:count] % coupon[:num])
      end
    end
  end
  new_cart
end

def apply_clearance(cart)
  # code here
  new_cart = {}
  cart.each { |ingredient, attributes| new_cart[ingredient] = attributes }
  cart.each do |ingredient, attributes|
    if attributes[:clearance] == true
      new_cart[ingredient][:price] = (new_cart[ingredient][:price] * (0.8)).round(2)
    end
  end
  new_cart
end

def checkout(cart, coupons)
  # code here
  consolidated = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated, coupons)
  clearance_applied = apply_clearance(coupons_applied)

  cost = 0
  clearance_applied.each do |ingredient, attributes|
    cost += (attributes[:price] * attributes[:count])
  end
  cost = (cost * (0.9)) if cost > 100
  cost
end
