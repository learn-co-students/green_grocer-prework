def consolidate_cart(cart)
  consol_cart = {}
  
  cart.each do |item|
    item.each do |key, value|
      if consol_cart.has_key?(key)
        consol_cart[key][:count] += 1 
      else
        consol_cart[key] = value
        consol_cart[key][:count] = 1 
      end
    end
  end
  consol_cart
end

def apply_coupons(cart, coupons)
  
  coupon_cart = {}
 
  cart.each do |item, details|
   coupons.each do |coupon|
     if item == coupon[:item] && details[:count] >= coupon[:num]
       details[:count] = details[:count] - coupon[:num]
       if coupon_cart["#{item} W/COUPON"]
         coupon_cart["#{item} W/COUPON"][:count] += 1 
       else
         coupon_cart["#{item} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => details[:clearance],
          :count => 1
         }
       end
     end
   end
 coupon_cart[item] = details
 end
 coupon_cart
end

def apply_clearance(cart)
  cart.each do |item, details|
    if details[:clearance] == true 
      details[:price] = (details[:price] * 0.8).round(2)
    end
  end
  cart 
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  
  if cart.length == 1 
    cart = apply_coupons(cart,coupons)
    cart = apply_clearance(cart)
  else
    cart = apply_coupons(cart,coupons)
    cart= apply_clearance(cart)
  end
  
  subtotal = 0 
  
  cart.each do |item,details|
    total_item_price = details[:price] * details[:count]
    total_item_price.to_f 
    subtotal += total_item_price
  end
  
  if subtotal > 100
    subtotal = subtotal * 0.9
  end
  
  subtotal
end
