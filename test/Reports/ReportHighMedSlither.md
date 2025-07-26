**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [arbitrary-send-erc20](#arbitrary-send-erc20) (2 results) (High)
 - [incorrect-exp](#incorrect-exp) (3 results) (High)
 - [incorrect-shift](#incorrect-shift) (8 results) (High)
 - [divide-before-multiply](#divide-before-multiply) (36 results) (Medium)
 - [incorrect-equality](#incorrect-equality) (1 results) (Medium)
 - [locked-ether](#locked-ether) (3 results) (Medium)
 - [uninitialized-local](#uninitialized-local) (5 results) (Medium)
 - [unused-return](#unused-return) (9 results) (Medium)
 - [write-after-write](#write-after-write) (4 results) (Medium)
## arbitrary-send-erc20
Impact: High
Confidence: High
 - [ ] ID-0
[AccountManager.depositFromRouter(address,address,uint256)](contracts/account-manager/AccountManager.sol#L172-L175) uses arbitrary from in transferFrom: [token.safeTransferFrom(gteRouter,address(this),amount)](contracts/account-manager/AccountManager.sol#L174)

contracts/account-manager/AccountManager.sol#L172-L175


 - [ ] ID-1
[AccountManager.deposit(address,address,uint256)](contracts/account-manager/AccountManager.sol#L166-L169) uses arbitrary from in transferFrom: [token.safeTransferFrom(account,address(this),amount)](contracts/account-manager/AccountManager.sol#L168)

contracts/account-manager/AccountManager.sol#L166-L169


## incorrect-exp
Impact: High
Confidence: Medium
 - [ ] ID-2
[FixedPointMathLib.fullMulDiv(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L455-L512) has bitwise-xor operator ^ instead of the exponentiation operator **: 
	 - [inv_fullMulDiv_asm_0 = 2 ^ 3 * d](lib/solady/src/utils/FixedPointMathLib.sol#L489)

lib/solady/src/utils/FixedPointMathLib.sol#L455-L512


 - [ ] ID-3
[FixedPointMathLib.fullMulDivUnchecked(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L517-L542) has bitwise-xor operator ^ instead of the exponentiation operator **: 
	 - [inv_fullMulDivUnchecked_asm_0 = 2 ^ 3 * d](lib/solady/src/utils/FixedPointMathLib.sol#L530)

lib/solady/src/utils/FixedPointMathLib.sol#L517-L542


 - [ ] ID-4
[FixedPointMathLib.cbrt(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L785-L806) has bitwise-xor operator ^ instead of the exponentiation operator **: 
	 - [z = 0xf << 0xf < x >> r_cbrt_asm_0 << r_cbrt_asm_0 / 3 / 7 ^ r_cbrt_asm_0 % 3](lib/solady/src/utils/FixedPointMathLib.sol#L794)

lib/solady/src/utils/FixedPointMathLib.sol#L785-L806


## incorrect-shift
Impact: High
Confidence: High
 - [ ] ID-5
[FixedPointMathLib.cbrt(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L785-L806) contains an incorrect shift operation: [z = 0xf << 0xf < x >> r_cbrt_asm_0 << r_cbrt_asm_0 / 3 / 7 ^ r_cbrt_asm_0 % 3](lib/solady/src/utils/FixedPointMathLib.sol#L794)

lib/solady/src/utils/FixedPointMathLib.sol#L785-L806


 - [ ] ID-6
[FixedPointMathLib.log2(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L866-L878) contains an incorrect shift operation: [r = r | byte(uint256,uint256)(0x1f & 0x8421084210842108cc6318c6db6d54be >> x >> r,0x0706060506020504060203020504030106050205030304010505030400000000)](lib/solady/src/utils/FixedPointMathLib.sol#L875-L876)

lib/solady/src/utils/FixedPointMathLib.sol#L866-L878


 - [ ] ID-7
[FixedPointMathLib.lnWad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L277-L347) contains an incorrect shift operation: [r = r ^ byte(uint256,uint256)(0x1f & 0x8421084210842108cc6318c6db6d54be >> x >> r,0xf8f9f9faf9fdfafbf9fdfcfdfafbfcfef9fafdfafcfcfbfefafafcfbffffffff)](lib/solady/src/utils/FixedPointMathLib.sol#L297-L298)

lib/solady/src/utils/FixedPointMathLib.sol#L277-L347


 - [ ] ID-8
[FixedPointMathLib.lambertW0Wad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L353-L434) contains an incorrect shift operation: [w = 7 << l_lambertW0Wad_asm_0 /' byte(uint256,uint256)(l_lambertW0Wad_asm_0 - 31,0x0303030303030303040506080c13)](lib/solady/src/utils/FixedPointMathLib.sol#L374)

lib/solady/src/utils/FixedPointMathLib.sol#L353-L434


 - [ ] ID-9
[OwnableRoles._rolesFromOrdinals(uint8[])](lib/solady/src/auth/OwnableRoles.sol#L161-L170) contains an incorrect shift operation: [roles = 1 << mload(uint256)(ordinals + i__rolesFromOrdinals_asm_0) | roles](lib/solady/src/auth/OwnableRoles.sol#L167)

lib/solady/src/auth/OwnableRoles.sol#L161-L170


 - [ ] ID-10
[FixedPointMathLib.log256Up(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L940-L946) contains an incorrect shift operation: [r = r + 1 << r << 3 < x](lib/solady/src/utils/FixedPointMathLib.sol#L944)

lib/solady/src/utils/FixedPointMathLib.sol#L940-L946


 - [ ] ID-11
[FixedPointMathLib.lambertW0Wad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L353-L434) contains an incorrect shift operation: [l_lambertW0Wad_asm_0 = l_lambertW0Wad_asm_0 | byte(uint256,uint256)(0x1f & 0x8421084210842108cc6318c6db6d54be >> v_lambertW0Wad_asm_0 >> l_lambertW0Wad_asm_0,0x0706060506020504060203020504030106050205030304010505030400000000) + 49](lib/solady/src/utils/FixedPointMathLib.sol#L372-L373)

lib/solady/src/utils/FixedPointMathLib.sol#L353-L434


 - [ ] ID-12
[FixedPointMathLib.log2Up(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L882-L888) contains an incorrect shift operation: [r = r + 1 << r < x](lib/solady/src/utils/FixedPointMathLib.sol#L886)

lib/solady/src/utils/FixedPointMathLib.sol#L882-L888


## divide-before-multiply
Impact: Medium
Confidence: Medium
 - [ ] ID-13
[CLOB._matchIncomingOrder(Book,Order,Order,uint256,bool)](contracts/clob/CLOB.sol#L807-L848) performs a multiplication on the result of a division:
	- [matchData.baseDelta = (matchedBase.min(ds.getBaseTokenAmount(matchedPrice,takerOrder.amount)) / lotSize) * lotSize](contracts/clob/CLOB.sol#L824-L825)

contracts/clob/CLOB.sol#L807-L848


 - [ ] ID-14
[FixedPointMathLib.fullMulDivUnchecked(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L517-L542) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L529)
	- [inv_fullMulDivUnchecked_asm_0 = inv_fullMulDivUnchecked_asm_0 * 2 - d * inv_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L534)

lib/solady/src/utils/FixedPointMathLib.sol#L517-L542


 - [ ] ID-15
[FixedPointMathLib.expWad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L207-L272) performs a multiplication on the result of a division:
	- [x = (x << 78) / 5 ** 18](lib/solady/src/utils/FixedPointMathLib.sol#L226)
	- [y = ((y * x) >> 96) + 57155421227552351082224309758442](lib/solady/src/utils/FixedPointMathLib.sol#L239)

lib/solady/src/utils/FixedPointMathLib.sol#L207-L272


 - [ ] ID-16
[FixedPointMathLib.fullMulDivUnchecked(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L517-L542) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L529)
	- [inv_fullMulDivUnchecked_asm_0 = 2 ^ 3 * d](lib/solady/src/utils/FixedPointMathLib.sol#L530)

lib/solady/src/utils/FixedPointMathLib.sol#L517-L542


 - [ ] ID-17
[FixedPointMathLib.fullMulDiv(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L455-L512) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L483)
	- [inv_fullMulDiv_asm_0 = inv_fullMulDiv_asm_0 * 2 - d * inv_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L493)

lib/solady/src/utils/FixedPointMathLib.sol#L455-L512


 - [ ] ID-18
[FixedPointMathLib.fullMulDiv(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L455-L512) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L483)
	- [inv_fullMulDiv_asm_0 = 2 ^ 3 * d](lib/solady/src/utils/FixedPointMathLib.sol#L489)

lib/solady/src/utils/FixedPointMathLib.sol#L455-L512


 - [ ] ID-19
[FixedPointMathLib.expWad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L207-L272) performs a multiplication on the result of a division:
	- [x = (x << 78) / 5 ** 18](lib/solady/src/utils/FixedPointMathLib.sol#L226)
	- [p = p * x + (4385272521454847904659076985693276 << 96)](lib/solady/src/utils/FixedPointMathLib.sol#L242)

lib/solady/src/utils/FixedPointMathLib.sol#L207-L272


 - [ ] ID-20
[FixedPointMathLib.cbrt(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L785-L806) performs a multiplication on the result of a division:
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L800)
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L801)

lib/solady/src/utils/FixedPointMathLib.sol#L785-L806


 - [ ] ID-21
[FixedPointMathLib.fullMulDiv(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L455-L512) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L483)
	- [inv_fullMulDiv_asm_0 = inv_fullMulDiv_asm_0 * 2 - d * inv_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L494)

lib/solady/src/utils/FixedPointMathLib.sol#L455-L512


 - [ ] ID-22
[FixedPointMathLib.cbrtWad(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L824-L848) performs a multiplication on the result of a division:
	- [z = (fullMulDivUnchecked(x,10 ** 36,z * z) + z + z) / 3](lib/solady/src/utils/FixedPointMathLib.sol#L828)
	- [t_cbrtWad_asm_0 = mulmod(uint256,uint256,uint256)(z * z,z,p_cbrtWad_asm_0)](lib/solady/src/utils/FixedPointMathLib.sol#L845)

lib/solady/src/utils/FixedPointMathLib.sol#L824-L848


 - [ ] ID-23
[FixedPointMathLib.cbrt(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L785-L806) performs a multiplication on the result of a division:
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L802)
	- [z = z - x / z * z < z](lib/solady/src/utils/FixedPointMathLib.sol#L804)

lib/solady/src/utils/FixedPointMathLib.sol#L785-L806


 - [ ] ID-24
[FixedPointMathLib.rpow(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L690-L724) performs a multiplication on the result of a division:
	- [x = xxRound_rpow_asm_0 / b](lib/solady/src/utils/FixedPointMathLib.sol#L706)
	- [zx_rpow_asm_0 = z * x](lib/solady/src/utils/FixedPointMathLib.sol#L709)

lib/solady/src/utils/FixedPointMathLib.sol#L690-L724


 - [ ] ID-25
[FixedPointMathLib.cbrt(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L785-L806) performs a multiplication on the result of a division:
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L798)
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L799)

lib/solady/src/utils/FixedPointMathLib.sol#L785-L806


 - [ ] ID-26
[FixedPointMathLib.fullMulDiv(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L455-L512) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L483)
	- [z = p1_fullMulDiv_asm_0 - r_fullMulDiv_asm_0 > z * 0 - t_fullMulDiv_asm_0 / t_fullMulDiv_asm_0 + 1 | z - r_fullMulDiv_asm_0 / t_fullMulDiv_asm_0 * 2 - d * inv_fullMulDiv_asm_0 * inv_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L498-L505)

lib/solady/src/utils/FixedPointMathLib.sol#L455-L512


 - [ ] ID-27
[FixedPointMathLib.cbrt(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L785-L806) performs a multiplication on the result of a division:
	- [z = 0xf << 0xf < x >> r_cbrt_asm_0 << r_cbrt_asm_0 / 3 / 7 ^ r_cbrt_asm_0 % 3](lib/solady/src/utils/FixedPointMathLib.sol#L794)
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L796)

lib/solady/src/utils/FixedPointMathLib.sol#L785-L806


 - [ ] ID-28
[FixedPointMathLib.expWad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L207-L272) performs a multiplication on the result of a division:
	- [x = (x << 78) / 5 ** 18](lib/solady/src/utils/FixedPointMathLib.sol#L226)
	- [q = ((q * x) >> 96) - 533845033583426703283633433725380](lib/solady/src/utils/FixedPointMathLib.sol#L247)

lib/solady/src/utils/FixedPointMathLib.sol#L207-L272


 - [ ] ID-29
[FixedPointMathLib.cbrt(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L785-L806) performs a multiplication on the result of a division:
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L796)
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L797)

lib/solady/src/utils/FixedPointMathLib.sol#L785-L806


 - [ ] ID-30
[FixedPointMathLib.fullMulDiv(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L455-L512) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L483)
	- [inv_fullMulDiv_asm_0 = inv_fullMulDiv_asm_0 * 2 - d * inv_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L496)

lib/solady/src/utils/FixedPointMathLib.sol#L455-L512


 - [ ] ID-31
[FixedPointMathLib.fullMulDivUnchecked(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L517-L542) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L529)
	- [z = p1_fullMulDivUnchecked_asm_0 - r_fullMulDivUnchecked_asm_0 > z * 0 - t_fullMulDivUnchecked_asm_0 / t_fullMulDivUnchecked_asm_0 + 1 | z - r_fullMulDivUnchecked_asm_0 / t_fullMulDivUnchecked_asm_0 * 2 - d * inv_fullMulDivUnchecked_asm_0 * inv_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L536-L540)

lib/solady/src/utils/FixedPointMathLib.sol#L517-L542


 - [ ] ID-32
[FixedPointMathLib.expWad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L207-L272) performs a multiplication on the result of a division:
	- [x = (x << 78) / 5 ** 18](lib/solady/src/utils/FixedPointMathLib.sol#L226)
	- [q = ((q * x) >> 96) - 14423608567350463180887372962807573](lib/solady/src/utils/FixedPointMathLib.sol#L249)

lib/solady/src/utils/FixedPointMathLib.sol#L207-L272


 - [ ] ID-33
[FixedPointMathLib.cbrt(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L785-L806) performs a multiplication on the result of a division:
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L801)
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L802)

lib/solady/src/utils/FixedPointMathLib.sol#L785-L806


 - [ ] ID-34
[FixedPointMathLib.fullMulDivUnchecked(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L517-L542) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L529)
	- [inv_fullMulDivUnchecked_asm_0 = inv_fullMulDivUnchecked_asm_0 * 2 - d * inv_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L533)

lib/solady/src/utils/FixedPointMathLib.sol#L517-L542


 - [ ] ID-35
[FixedPointMathLib.expWad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L207-L272) performs a multiplication on the result of a division:
	- [x = (x << 78) / 5 ** 18](lib/solady/src/utils/FixedPointMathLib.sol#L226)
	- [q = ((q * x) >> 96) + 26449188498355588339934803723976023](lib/solady/src/utils/FixedPointMathLib.sol#L250)

lib/solady/src/utils/FixedPointMathLib.sol#L207-L272


 - [ ] ID-36
[FixedPointMathLib.fullMulDivUnchecked(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L517-L542) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L529)
	- [inv_fullMulDivUnchecked_asm_0 = inv_fullMulDivUnchecked_asm_0 * 2 - d * inv_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L532)

lib/solady/src/utils/FixedPointMathLib.sol#L517-L542


 - [ ] ID-37
[FixedPointMathLib.invMod(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L624-L641) performs a multiplication on the result of a division:
	- [q_invMod_asm_0 = g_invMod_asm_0 / r_invMod_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L630)
	- [y_invMod_asm_0 = u_invMod_asm_0 - y_invMod_asm_0 * q_invMod_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L636)

lib/solady/src/utils/FixedPointMathLib.sol#L624-L641


 - [ ] ID-38
[FixedPointMathLib.fullMulDivUnchecked(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L517-L542) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L529)
	- [inv_fullMulDivUnchecked_asm_0 = inv_fullMulDivUnchecked_asm_0 * 2 - d * inv_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L535)

lib/solady/src/utils/FixedPointMathLib.sol#L517-L542


 - [ ] ID-39
[FixedPointMathLib.invMod(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L624-L641) performs a multiplication on the result of a division:
	- [q_invMod_asm_0 = g_invMod_asm_0 / r_invMod_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L630)
	- [r_invMod_asm_0 = t_invMod_asm_0 - r_invMod_asm_0 * q_invMod_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L633)

lib/solady/src/utils/FixedPointMathLib.sol#L624-L641


 - [ ] ID-40
[FixedPointMathLib.lambertW0Wad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L353-L434) performs a multiplication on the result of a division:
	- [t_lambertW0Wad_asm_2 = w * e / wad](lib/solady/src/utils/FixedPointMathLib.sol#L392)

lib/solady/src/utils/FixedPointMathLib.sol#L353-L434


 - [ ] ID-41
[CLOB._matchIncomingOrder(Book,Order,Order,uint256,bool)](contracts/clob/CLOB.sol#L807-L848) performs a multiplication on the result of a division:
	- [matchData.baseDelta = (matchedBase.min(takerOrder.amount) / lotSize) * lotSize](contracts/clob/CLOB.sol#L819)

contracts/clob/CLOB.sol#L807-L848


 - [ ] ID-42
[FixedPointMathLib.expWad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L207-L272) performs a multiplication on the result of a division:
	- [x = (x << 78) / 5 ** 18](lib/solady/src/utils/FixedPointMathLib.sol#L226)
	- [q = ((q * x) >> 96) + 3604857256930695427073651918091429](lib/solady/src/utils/FixedPointMathLib.sol#L248)

lib/solady/src/utils/FixedPointMathLib.sol#L207-L272


 - [ ] ID-43
[FixedPointMathLib.cbrt(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L785-L806) performs a multiplication on the result of a division:
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L797)
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L798)

lib/solady/src/utils/FixedPointMathLib.sol#L785-L806


 - [ ] ID-44
[FixedPointMathLib.cbrt(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L785-L806) performs a multiplication on the result of a division:
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L799)
	- [z = x / z * z + z + z / 3](lib/solady/src/utils/FixedPointMathLib.sol#L800)

lib/solady/src/utils/FixedPointMathLib.sol#L785-L806


 - [ ] ID-45
[FixedPointMathLib.expWad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L207-L272) performs a multiplication on the result of a division:
	- [x = (x << 78) / 5 ** 18](lib/solady/src/utils/FixedPointMathLib.sol#L226)
	- [q = ((q * x) >> 96) + 50020603652535783019961831881945](lib/solady/src/utils/FixedPointMathLib.sol#L246)

lib/solady/src/utils/FixedPointMathLib.sol#L207-L272


 - [ ] ID-46
[FixedPointMathLib.fullMulDiv(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L455-L512) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L483)
	- [inv_fullMulDiv_asm_0 = inv_fullMulDiv_asm_0 * 2 - d * inv_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L495)

lib/solady/src/utils/FixedPointMathLib.sol#L455-L512


 - [ ] ID-47
[FixedPointMathLib.fullMulDiv(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L455-L512) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L483)
	- [inv_fullMulDiv_asm_0 = inv_fullMulDiv_asm_0 * 2 - d * inv_fullMulDiv_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L497)

lib/solady/src/utils/FixedPointMathLib.sol#L455-L512


 - [ ] ID-48
[FixedPointMathLib.fullMulDivUnchecked(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L517-L542) performs a multiplication on the result of a division:
	- [d = d / t_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L529)
	- [inv_fullMulDivUnchecked_asm_0 = inv_fullMulDivUnchecked_asm_0 * 2 - d * inv_fullMulDivUnchecked_asm_0](lib/solady/src/utils/FixedPointMathLib.sol#L531)

lib/solady/src/utils/FixedPointMathLib.sol#L517-L542


## incorrect-equality
Impact: Medium
Confidence: High
 - [ ] ID-49
[GTERouter._executeClobPostFillOrder(GTERouter.__RouteMetadata__,bytes)](contracts/router/GTERouter.sol#L293-L322) uses a dangerous strict equality:
	- [fillArgs.side == Side.BUY](contracts/router/GTERouter.sol#L317-L319)

contracts/router/GTERouter.sol#L293-L322


## locked-ether
Impact: Medium
Confidence: High
 - [ ] ID-50
Contract locking ether found:
	Contract [Distributor](contracts/launchpad/Distributor.sol#L13-L198) has payable functions:
	 - [OwnableRoles.grantRoles(address,uint256)](lib/solady/src/auth/OwnableRoles.sol#L207-L209)
	 - [OwnableRoles.revokeRoles(address,uint256)](lib/solady/src/auth/OwnableRoles.sol#L213-L215)
	 - [OwnableRoles.renounceRoles(uint256)](lib/solady/src/auth/OwnableRoles.sol#L219-L221)
	 - [Ownable.transferOwnership(address)](lib/solady/src/auth/Ownable.sol#L174-L183)
	 - [Ownable.renounceOwnership()](lib/solady/src/auth/Ownable.sol#L186-L188)
	 - [Ownable.requestOwnershipHandover()](lib/solady/src/auth/Ownable.sol#L192-L205)
	 - [Ownable.cancelOwnershipHandover()](lib/solady/src/auth/Ownable.sol#L208-L218)
	 - [Ownable.completeOwnershipHandover(address)](lib/solady/src/auth/Ownable.sol#L222-L238)
	But does not have a function to withdraw the ether

contracts/launchpad/Distributor.sol#L13-L198


 - [ ] ID-51
Contract locking ether found:
	Contract [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341) has payable functions:
	 - [OwnableRoles.grantRoles(address,uint256)](lib/solady/src/auth/OwnableRoles.sol#L207-L209)
	 - [OwnableRoles.revokeRoles(address,uint256)](lib/solady/src/auth/OwnableRoles.sol#L213-L215)
	 - [OwnableRoles.renounceRoles(uint256)](lib/solady/src/auth/OwnableRoles.sol#L219-L221)
	 - [Ownable.transferOwnership(address)](lib/solady/src/auth/Ownable.sol#L174-L183)
	 - [Ownable.renounceOwnership()](lib/solady/src/auth/Ownable.sol#L186-L188)
	 - [Ownable.requestOwnershipHandover()](lib/solady/src/auth/Ownable.sol#L192-L205)
	 - [Ownable.cancelOwnershipHandover()](lib/solady/src/auth/Ownable.sol#L208-L218)
	 - [Ownable.completeOwnershipHandover(address)](lib/solady/src/auth/Ownable.sol#L222-L238)
	But does not have a function to withdraw the ether

contracts/account-manager/AccountManager.sol#L27-L341


 - [ ] ID-52
Contract locking ether found:
	Contract [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341) has payable functions:
	 - [OwnableRoles.grantRoles(address,uint256)](lib/solady/src/auth/OwnableRoles.sol#L207-L209)
	 - [OwnableRoles.revokeRoles(address,uint256)](lib/solady/src/auth/OwnableRoles.sol#L213-L215)
	 - [OwnableRoles.renounceRoles(uint256)](lib/solady/src/auth/OwnableRoles.sol#L219-L221)
	 - [Ownable.transferOwnership(address)](lib/solady/src/auth/Ownable.sol#L174-L183)
	 - [Ownable.renounceOwnership()](lib/solady/src/auth/Ownable.sol#L186-L188)
	 - [Ownable.requestOwnershipHandover()](lib/solady/src/auth/Ownable.sol#L192-L205)
	 - [Ownable.cancelOwnershipHandover()](lib/solady/src/auth/Ownable.sol#L208-L218)
	 - [Ownable.completeOwnershipHandover(address)](lib/solady/src/auth/Ownable.sol#L222-L238)
	But does not have a function to withdraw the ether

contracts/clob/CLOBManager.sol#L54-L341


## uninitialized-local
Impact: Medium
Confidence: Medium
 - [ ] ID-53
[CLOB._removeNonCompetitiveOrder(Book,Order).quoteRefunded](contracts/clob/CLOB.sol#L876) is a local variable never initialized

contracts/clob/CLOB.sol#L876


 - [ ] ID-54
[CLOB._settleIncomingOrder(Book,address,Side,uint256,uint256).settleParams](contracts/clob/CLOB.sol#L949) is a local variable never initialized

contracts/clob/CLOB.sol#L949


 - [ ] ID-55
[CLOB._removeNonCompetitiveOrder(Book,Order).baseRefunded](contracts/clob/CLOB.sol#L877) is a local variable never initialized

contracts/clob/CLOB.sol#L877


 - [ ] ID-56
[CLOBManager.createMarket(address,address,SettingsParams).config](contracts/clob/CLOBManager.sol#L177) is a local variable never initialized

contracts/clob/CLOBManager.sol#L177


 - [ ] ID-57
[CLOB._executeAmendNewOrder(Book,Order,ICLOB.AmendArgs).newOrder](contracts/clob/CLOB.sol#L678) is a local variable never initialized

contracts/clob/CLOB.sol#L678


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-58
[ERC1967Utils.upgradeBeaconToAndCall(address,bytes)](lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L157-L166) ignores return value by [Address.functionDelegateCall(IBeacon(newBeacon).implementation(),data)](lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L162)

lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L157-L166


 - [ ] ID-59
[Distributor.getPendingRewards(address,address)](contracts/launchpad/Distributor.sol#L77-L85) ignores return value by [rs.getPendingRewards(account)](contracts/launchpad/Distributor.sol#L84)

contracts/launchpad/Distributor.sol#L77-L85


 - [ ] ID-60
[GTERouter.clobAmend(ICLOB,ICLOB.AmendArgs)](contracts/router/GTERouter.sol#L168-L174) ignores return value by [clob.amend(msg.sender,args)](contracts/router/GTERouter.sol#L173)

contracts/router/GTERouter.sol#L168-L174


 - [ ] ID-61
[ERC1967Utils.upgradeToAndCall(address,bytes)](lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L67-L76) ignores return value by [Address.functionDelegateCall(newImplementation,data)](lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L72)

lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L67-L76


 - [ ] ID-62
[GTERouter.launchpadSell(address,uint256,uint256)](contracts/router/GTERouter.sol#L195-L207) ignores return value by [launchpad.sell({account:msg.sender,token:launchToken,recipient:msg.sender,amountInBase:amountInBase,minAmountOutQuote:worstAmountOutQuote})](contracts/router/GTERouter.sol#L200-L206)

contracts/router/GTERouter.sol#L195-L207


 - [ ] ID-63
[CLOB.getOrdersPaginated(OrderId,uint256)](contracts/clob/CLOB.sol#L295-L304) ignores return value by [ds.getOrdersPaginated(nextOrder,pageSize)](contracts/clob/CLOB.sol#L303)

contracts/clob/CLOB.sol#L295-L304


 - [ ] ID-64
[GTERouter.clobCancel(ICLOB,ICLOB.CancelArgs)](contracts/router/GTERouter.sol#L159-L165) ignores return value by [clob.cancel(msg.sender,args)](contracts/router/GTERouter.sol#L164)

contracts/router/GTERouter.sol#L159-L165


 - [ ] ID-65
[CLOB.getOrdersPaginated(uint256,Side,uint256)](contracts/clob/CLOB.sol#L280-L292) ignores return value by [ds.getOrdersPaginated(nextOrder,pageSize)](contracts/clob/CLOB.sol#L291)

contracts/clob/CLOB.sol#L280-L292


 - [ ] ID-66
[GTERouter.launchpadBuy(address,uint256,address,uint256)](contracts/router/GTERouter.sol#L210-L224) ignores return value by [launchpad.buy(ILaunchpad.BuyData({account:msg.sender,token:launchToken,recipient:msg.sender,amountOutBase:amountOutBase,maxAmountInQuote:worstAmountInQuote}))](contracts/router/GTERouter.sol#L215-L223)

contracts/router/GTERouter.sol#L210-L224


## write-after-write
Impact: Medium
Confidence: High
 - [ ] ID-67
[SafeTransferLib.permit2(address,address,address,uint256,uint256,uint8,bytes32,bytes32).success](lib/solady/src/utils/SafeTransferLib.sol#L471) is written in both
	[success = call(uint256,uint256,uint256,uint256,uint256,uint256,uint256)(gas()(),token,0,m_permit2_asm_0 + 0x10,0x104,codesize()(),0x00)](lib/solady/src/utils/SafeTransferLib.sol#L499)
	[success = call(uint256,uint256,uint256,uint256,uint256,uint256,uint256)(gas()(),token,0,m_permit2_asm_0 + 0x10,0xe4,codesize()(),0x00)](lib/solady/src/utils/SafeTransferLib.sol#L507)

lib/solady/src/utils/SafeTransferLib.sol#L471


 - [ ] ID-68
[CLOB._matchIncomingBid(Book,Order,bool).bestAskPrice](contracts/clob/CLOB.sol#L743) is written in both
	[bestAskPrice = ds.getBestAskPrice()](contracts/clob/CLOB.sol#L751)
	[bestAskPrice = ds.getBestAskPrice()](contracts/clob/CLOB.sol#L768)

contracts/clob/CLOB.sol#L743


 - [ ] ID-69
[CLOB._matchIncomingAsk(Book,Order,bool).bestBidPrice](contracts/clob/CLOB.sol#L777) is written in both
	[bestBidPrice = ds.getBestBidPrice()](contracts/clob/CLOB.sol#L785)
	[bestBidPrice = ds.getBestBidPrice()](contracts/clob/CLOB.sol#L802)

contracts/clob/CLOB.sol#L777


 - [ ] ID-70
[RedBlackTreeLib._update(uint256,uint256,uint256,uint256,uint256).err](lib/solady/src/utils/RedBlackTreeLib.sol#L350) is written in both
	[err = insert(nodes,cursor,key,x)](lib/solady/src/utils/RedBlackTreeLib.sol#L658)
	[err = remove(nodes,key)](lib/solady/src/utils/RedBlackTreeLib.sol#L661)

lib/solady/src/utils/RedBlackTreeLib.sol#L350