

def consolidate_cart(cart)

  hash ={}
  cart.each do |item|
    item.each do |key, item_hash|
      hash[key] ||= item_hash
      hash[key][:count] ||= 0
      hash[key][:count] += 1
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |name, properties|
    if properties[:clearance]
      updated_price = properties[:price] * 0.80
      properties[:price] = updated_price.round(2)
    end
  end
  cart
end


# 1. Apply coupon discounts if the proper number of items are present.
# 2. Apply 20% discount if items are on clearance.
# 3. If, after applying the coupon discounts and the clearance discounts, the cart's total is over $100, then apply a 10% discount.
def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  final_cart.each do |name, properties|
    total += properties[:price] * properties[:count]
  end
  total = total * 0.9 if total > 100
  total
end
