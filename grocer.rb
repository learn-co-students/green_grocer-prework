def consolidate_cart(cart)
  new_hash={}
  cart.each do |hash|
    hash.each do |key,value|
      if !new_hash.has_key?(key)
        new_hash[key]=value
        value[:count]=1
      elsif new_hash.has_key?(key)
        value[:count]+=1
      end
    end
end
new_hash
end

def apply_coupons(cart,coupons)
  new_hash={}
  cart.each do|key,value|
     new_hash[key]=value
    coupons.each do|each|
# nested if statements here
    if key==each[:item]&&new_hash[key][:count]>=each[:num]
    new_hash[key][:count]-=each[:num] 
      if new_hash["#{key} W/COUPON"]
       new_hash["#{key} W/COUPON"][:count]+=1
      else
        new_hash["#{key} W/COUPON"]={}
        new_hash["#{key} W/COUPON"][:price]=each[:cost]
        new_hash["#{key} W/COUPON"][:clearance]=value[:clearance]
        new_hash["#{key} W/COUPON"][:count] = 1
    end
  end
end
end
 new_hash
end

def apply_clearance(cart)
  hash={}
  cart.each do |key,value|
    hash[key] =value
    if value[:clearance]==true
      hash[key][:price]=(value[:price]*0.8).round(1)
  end
end
  hash
end

def checkout(cart, coupons)
  cart_consolidate=consolidate_cart(cart)
  cart_coupons=apply_coupons(cart_consolidate,coupons)
  cart_clearance=apply_clearance(cart_coupons)
  sum=0
  cart_clearance.each do |key,value|
    sum+=value[:price]*value[:count]
  end
  sum>100?sum*0.9:sum
end
