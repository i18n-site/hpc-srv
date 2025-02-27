#!/usr/bin/env coffee

> ./api.js > captcha set
  # ./_.pb.js > T0Encode:CallEncode T0Decode:CallDecode T1Encode:CallLiEncode T1Decode:CallLiDecode
  ./_.pb.js > T2Encode:BinLiEncode T2Decode:BinLiDecode

# for nginx https proxy use this
# set(
#   'https://127.0.0.1:7776'

set(
  'http://127.0.0.1:2025'
  console.error
  (headers)=>
    headers['accept-language'] = 'en'
    return
  (
    code
    msg
    req # [decode, resolve, reject, func_id, args_bin]
  )=>
    console.log({code, msg, req})
    return
)

[
  id
  img
  tip
] = await captcha()

console.log {id}

[
  [id1,img,tip]
  [id2,img,tip]
] = await Promise.all [
  captcha()
  captcha()
]
console.log {id1,id2}

setTimeout =>
  [id2,img,tip] = await captcha()
  console.log {id2}
  return

[id1,img,tip] = await captcha()
console.log {id1}
