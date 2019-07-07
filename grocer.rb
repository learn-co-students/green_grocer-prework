def consolidate_cart(cart)
  new_hash = {}
  cart.each do |item|
    item.each do |key,value|
      if new_hash[key]
        new_hash[key][:count]+=1
      else
        new_hash[key]=value
        new_hash[key][:count]=1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  updatedCart = {}
  cart.each do |item,details|
    coupons.each do |coupon|
      if item == coupon[:item]
        couponItem = details[:count]/coupon[:num]
        nonCouponItem = details[:count]%coupon[:num]
        if couponItem > 0
          updatedCart["#{item} W/COUPON"]= {
          :price => coupon[:cost],
          :clearance => details[:clearance],
          :count => couponItem
          }
        end
        updatedCart[item]={
        :price => details[:price],
        :clearance => details[:clearance],
        :count => nonCouponItem
        }
      end
    end
    updatedCart[item] ||= details
  end
  return updatedCart
end


def apply_clearance(cart)
  cart.each do |item,details|
    if details[:clearance]== true
      details[:price]=(details[:price]*0.8).round(2)
    end
  end
  return cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance(cart)
  total = 0
    cart.each do |item,details|
      total += (details[:price]*details[:count])
    end
    if total > 100
      total = (total*0.9).round(2)
    end
  return total
end
