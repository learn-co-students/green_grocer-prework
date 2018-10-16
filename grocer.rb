def consolidate_cart(cart)
  consolidated = {}
  cart.each do |element|
    element.each do |item, attributes|
        consolidated[item] = attributes
        consolidated[item][:count] = cart.count(element)
    end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  if coupons.length > 0
    coupons.each do |coupon|
      if cart.keys.include?(coupon[:item])
        if cart[coupon[:item]][:count] >= coupon[:num]
          cart[coupon[:item]][:count] = cart[coupon[:item]][:count] - coupon[:num]
          cart["#{coupon[:item]} W/COUPON"] = {}
          cart["#{coupon[:item]} W/COUPON"][:price] = coupon[:cost]
          cart["#{coupon[:item]} W/COUPON"][:clearance] = cart[coupon[:item]][:clearance]
          cart["#{coupon[:item]} W/COUPON"][:count] = coupons.count(coupon)
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  clearance_items = []
  cart.collect do |item, attributes|
    attributes.each do |attribute, value|
      if attribute == :clearance && value == true
        cart[item][:price] = (cart[item][:price] * 0.80).round(2)
      else
        cart[item][:price]
      end
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  sub_total = 0
  clearanced_cart.each do |item, attributes|
    if item.split[-1] != "W/COUPON"
      sub_total += (attributes[:price] * attributes[:count])
    else
      sub_total += attributes[:price]
    end
  end
  if sub_total > 100
    total = sub_total * 0.90
  else
    total = sub_total
  end
  total
end
