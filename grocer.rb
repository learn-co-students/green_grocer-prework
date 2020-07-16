def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |item|
    item.each do |product, value|
      if !consolidated_cart.keys.include?(product)
        consolidated_cart[product] = value
        consolidated_cart[product][:count] = 1
      else
        consolidated_cart[product][:count] += 1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  couponed = {}
  cart.each do |item, value|
    couponed[item] = value
    coupons.each do |discount|
      if discount[:item] == item && value[:count] >= discount[:num]
        if couponed.keys.include?("#{discount[:item]} W/COUPON")
          couponed[item][:count] -= discount[:num]
          couponed["#{discount[:item]} W/COUPON"][:count] += 1
        else
          couponed[item][:count] -= discount[:num]
          couponed["#{item} W/COUPON"] = {:price => discount[:cost], :clearance => value[:clearance], :count => 1}
        end
      end
    end
  end
  couponed
end

def apply_clearance(cart)
  cart.each do |item, value|
    if value[:clearance]
      value[:price] = value[:price] - (2 * value[:price] / 10)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed = apply_coupons(consolidated_cart, coupons)
  checked_cart = apply_clearance(couponed)
  total = 0.0

  checked_cart.each do |item, value|
    total += value[:price] * value[:count]
  end

  if total > 100.0
    total = total - (total / 10.0)
  end
  total
end
