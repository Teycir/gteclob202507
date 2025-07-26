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
 - [events-access](#events-access) (1 results) (Low)
 - [missing-zero-check](#missing-zero-check) (5 results) (Low)
 - [calls-loop](#calls-loop) (3 results) (Low)
 - [reentrancy-events](#reentrancy-events) (5 results) (Low)
 - [timestamp](#timestamp) (4 results) (Low)
 - [assembly](#assembly) (150 results) (Informational)
 - [pragma](#pragma) (1 results) (Informational)
 - [cyclomatic-complexity](#cyclomatic-complexity) (2 results) (Informational)
 - [solc-version](#solc-version) (4 results) (Informational)
 - [incorrect-using-for](#incorrect-using-for) (3 results) (Informational)
 - [low-level-calls](#low-level-calls) (4 results) (Informational)
 - [naming-convention](#naming-convention) (40 results) (Informational)
 - [too-many-digits](#too-many-digits) (35 results) (Informational)
 - [unused-state](#unused-state) (767 results) (Informational)
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


## events-access
Impact: Low
Confidence: Medium
 - [ ] ID-71
[Distributor.initialize(address)](contracts/launchpad/Distributor.sol#L39-L43) should emit an event for: 
	- [launchpad = _launchpad](contracts/launchpad/Distributor.sol#L41) 

contracts/launchpad/Distributor.sol#L39-L43


## missing-zero-check
Impact: Low
Confidence: Medium
 - [ ] ID-72
[AccountManager.constructor(address,address,uint16[],uint16[])._gteRouter](contracts/account-manager/AccountManager.sol#L105) lacks a zero-check on :
		- [gteRouter = _gteRouter](contracts/account-manager/AccountManager.sol#L110)

contracts/account-manager/AccountManager.sol#L105


 - [ ] ID-73
[Distributor.initialize(address)._launchpad](contracts/launchpad/Distributor.sol#L39) lacks a zero-check on :
		- [launchpad = _launchpad](contracts/launchpad/Distributor.sol#L41)

contracts/launchpad/Distributor.sol#L39


 - [ ] ID-74
[AccountManager.constructor(address,address,uint16[],uint16[])._clobManager](contracts/account-manager/AccountManager.sol#L106) lacks a zero-check on :
		- [clobManager = _clobManager](contracts/account-manager/AccountManager.sol#L111)

contracts/account-manager/AccountManager.sol#L106


 - [ ] ID-75
[BeaconProxy.constructor(address,bytes).beacon](lib/openzeppelin-contracts/contracts/proxy/beacon/BeaconProxy.sol#L39) lacks a zero-check on :
		- [_beacon = beacon](lib/openzeppelin-contracts/contracts/proxy/beacon/BeaconProxy.sol#L41)

lib/openzeppelin-contracts/contracts/proxy/beacon/BeaconProxy.sol#L39


 - [ ] ID-76
[CLOB.constructor(address,address,address,uint256)._gteRouter](contracts/clob/CLOB.sol#L160) lacks a zero-check on :
		- [gteRouter = _gteRouter](contracts/clob/CLOB.sol#L162)

contracts/clob/CLOB.sol#L160


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-77
[CLOBManager.setMaxLimitsPerTx(ICLOB[],uint8[])](contracts/clob/CLOBManager.sol#L223-L233) has external calls inside a loop: [clobs[i].setMaxLimitsPerTx(maxLimits[i])](contracts/clob/CLOBManager.sol#L231)

contracts/clob/CLOBManager.sol#L223-L233


 - [ ] ID-78
[CLOBManager.setMinLimitOrderAmounts(ICLOB[],uint256[])](contracts/clob/CLOBManager.sol#L249-L259) has external calls inside a loop: [clobs[i].setMinLimitOrderAmountInBase(minLimitOrderAmounts[i])](contracts/clob/CLOBManager.sol#L257)

contracts/clob/CLOBManager.sol#L249-L259


 - [ ] ID-79
[CLOBManager.setTickSizes(ICLOB[],uint256[])](contracts/clob/CLOBManager.sol#L236-L246) has external calls inside a loop: [clobs[i].setTickSize(tickSizes[i])](contracts/clob/CLOBManager.sol#L244)

contracts/clob/CLOBManager.sol#L236-L246


## reentrancy-events
Impact: Low
Confidence: Medium
 - [ ] ID-80
Reentrancy in [CLOB._processAmend(Book,Order,ICLOB.AmendArgs)](contracts/clob/CLOB.sol#L644-L671):
	External calls:
	- [(quoteTokenDelta,baseTokenDelta) = _executeAmendNewOrder(ds,order,args)](contracts/clob/CLOB.sol#L660)
		- [accountManager.creditAccountNoEvent(order.owner,address(ds.config().quoteToken),quoteRefunded)](contracts/clob/CLOB.sol#L880)
		- [accountManager.creditAccountNoEvent(order.owner,address(ds.config().baseToken),baseRefunded)](contracts/clob/CLOB.sol#L883)
	Event emitted after the call(s):
	- [OrderAmended(EventNonceLib.inc(),preAmend,args,quoteTokenDelta,baseTokenDelta)](contracts/clob/CLOB.sol#L668)

contracts/clob/CLOB.sol#L644-L671


 - [ ] ID-81
Reentrancy in [CLOBManager.createMarket(address,address,SettingsParams)](contracts/clob/CLOBManager.sol#L166-L220):
	External calls:
	- [marketAddress = address(new BeaconProxy(beacon,initData))](contracts/clob/CLOBManager.sol#L211)
	- [accountManager.registerMarket(marketAddress)](contracts/clob/CLOBManager.sol#L217)
	Event emitted after the call(s):
	- [MarketCreated(EventNonceLib.inc(),creator,config.baseToken,config.quoteToken,marketAddress,quoteDecimals,baseDecimals,config,settings)](contracts/clob/CLOBManager.sol#L317-L327)
		- [_emitMarketCreated(msg.sender,marketAddress,quoteDecimals,baseDecimals,config,settings)](contracts/clob/CLOBManager.sol#L219)

contracts/clob/CLOBManager.sol#L166-L220


 - [ ] ID-82
Reentrancy in [CLOB._processLimitBidOrder(Book,address,Order,ICLOB.PostLimitOrderArgs)](contracts/clob/CLOB.sol#L492-L530):
	External calls:
	- [(postAmount,quoteTokenAmountSent,baseTokenAmountReceived) = _executeBidLimitOrder(ds,newOrder,args.limitOrderType)](contracts/clob/CLOB.sol#L498-L499)
		- [accountManager.creditAccountNoEvent(order.owner,address(ds.config().quoteToken),quoteRefunded)](contracts/clob/CLOB.sol#L880)
		- [accountManager.creditAccountNoEvent(order.owner,address(ds.config().baseToken),baseRefunded)](contracts/clob/CLOB.sol#L883)
	- [takerFee = _settleIncomingOrder(ds,account,Side.BUY,quoteTokenAmountSent + postAmount,baseTokenAmountReceived)](contracts/clob/CLOB.sol#L509-L510)
		- [accountManager.settleIncomingOrder(settleParams)](contracts/clob/CLOB.sol#L961)
	Event emitted after the call(s):
	- [LimitOrderProcessed(eventNonce,account,newOrder.id.unwrap(),newOrder.amount,- quoteTokenAmountSent.toInt256(),baseTokenAmountReceived.toInt256(),takerFee)](contracts/clob/CLOB.sol#L512-L520)

contracts/clob/CLOB.sol#L492-L530


 - [ ] ID-83
Reentrancy in [CLOB._processLimitAskOrder(Book,address,Order,ICLOB.PostLimitOrderArgs)](contracts/clob/CLOB.sol#L533-L571):
	External calls:
	- [(postAmount,quoteTokenAmountReceived,baseTokenAmountSent) = _executeAskLimitOrder(ds,newOrder,args.limitOrderType)](contracts/clob/CLOB.sol#L539-L540)
		- [accountManager.creditAccountNoEvent(order.owner,address(ds.config().quoteToken),quoteRefunded)](contracts/clob/CLOB.sol#L880)
		- [accountManager.creditAccountNoEvent(order.owner,address(ds.config().baseToken),baseRefunded)](contracts/clob/CLOB.sol#L883)
	- [takerFee = _settleIncomingOrder(ds,account,Side.SELL,quoteTokenAmountReceived,baseTokenAmountSent + postAmount)](contracts/clob/CLOB.sol#L550-L551)
		- [accountManager.settleIncomingOrder(settleParams)](contracts/clob/CLOB.sol#L961)
	Event emitted after the call(s):
	- [LimitOrderProcessed(eventNonce,account,newOrder.id.unwrap(),newOrder.amount,quoteTokenAmountReceived.toInt256(),- baseTokenAmountSent.toInt256(),takerFee)](contracts/clob/CLOB.sol#L553-L561)

contracts/clob/CLOB.sol#L533-L571


 - [ ] ID-84
Reentrancy in [CLOB._removeNonCompetitiveOrder(Book,Order)](contracts/clob/CLOB.sol#L875-L896):
	External calls:
	- [accountManager.creditAccountNoEvent(order.owner,address(ds.config().quoteToken),quoteRefunded)](contracts/clob/CLOB.sol#L880)
	- [accountManager.creditAccountNoEvent(order.owner,address(ds.config().baseToken),baseRefunded)](contracts/clob/CLOB.sol#L883)
	Event emitted after the call(s):
	- [OrderCanceled(EventNonceLib.inc(),order.id.unwrap(),order.owner,quoteRefunded,baseRefunded,CancelType.NON_COMPETITIVE)](contracts/clob/CLOB.sol#L886-L893)

contracts/clob/CLOB.sol#L875-L896


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-85
[GTERouter.executeRoute(address,uint256,uint256,uint256,bytes[])](contracts/router/GTERouter.sol#L239-L249) uses timestamp for comparisons
	Dangerous comparisons:
	- [finalAmountOut < amountOutMin](contracts/router/GTERouter.sol#L248)

contracts/router/GTERouter.sol#L239-L249


 - [ ] ID-86
[GTERouter._executeAllHops(address,uint256,bytes[])](contracts/router/GTERouter.sol#L264-L289) uses timestamp for comparisons
	Dangerous comparisons:
	- [currHopType == HopType.CLOB_FILL](contracts/router/GTERouter.sol#L279)
	- [currHopType == HopType.UNI_V2_SWAP](contracts/router/GTERouter.sol#L281)

contracts/router/GTERouter.sol#L264-L289


 - [ ] ID-87
[GTERouter._executeUniV2SwapExactTokensForTokens(GTERouter.__RouteMetadata__,bytes)](contracts/router/GTERouter.sol#L324-L353) uses timestamp for comparisons
	Dangerous comparisons:
	- [path[0] != route.nextTokenIn](contracts/router/GTERouter.sol#L331)
	- [route.prevHopType != HopType.UNI_V2_SWAP](contracts/router/GTERouter.sol#L333)
	- [route.nextHopType != HopType.UNI_V2_SWAP](contracts/router/GTERouter.sol#L350)

contracts/router/GTERouter.sol#L324-L353


 - [ ] ID-88
[GTERouter._executeClobPostFillOrder(GTERouter.__RouteMetadata__,bytes)](contracts/router/GTERouter.sol#L293-L322) uses timestamp for comparisons
	Dangerous comparisons:
	- [market == address(0)](contracts/router/GTERouter.sol#L301)
	- [ICLOB(market).getQuoteToken() == route.nextTokenIn](contracts/router/GTERouter.sol#L306)
	- [fillArgs.side == Side.BUY](contracts/router/GTERouter.sol#L317-L319)

contracts/router/GTERouter.sol#L293-L322


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-89
[FixedPointMathLib.dist(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L1036-L1041) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1038-L1040)

lib/solady/src/utils/FixedPointMathLib.sol#L1036-L1041


 - [ ] ID-90
[FixedPointMathLib.mulWadUp(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L109-L122) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L111-L121)

lib/solady/src/utils/FixedPointMathLib.sol#L109-L122


 - [ ] ID-91
[FixedPointMathLib.fullMulEq(uint256,uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L441-L450) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L447-L449)

lib/solady/src/utils/FixedPointMathLib.sol#L441-L450


 - [ ] ID-92
[FixedPointMathLib.rawDivWad(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L160-L165) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L162-L164)

lib/solady/src/utils/FixedPointMathLib.sol#L160-L165


 - [ ] ID-93
[FixedPointMathLib.min(int256,int256)](lib/solady/src/utils/FixedPointMathLib.sol#L1060-L1065) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1062-L1064)

lib/solady/src/utils/FixedPointMathLib.sol#L1060-L1065


 - [ ] ID-94
[Initializable._getInitializedVersion()](lib/solady/src/utils/Initializable.sol#L169-L175) uses assembly
	- [INLINE ASM](lib/solady/src/utils/Initializable.sol#L172-L174)

lib/solady/src/utils/Initializable.sol#L169-L175


 - [ ] ID-95
[FixedPointMathLib.rawDiv(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L1208-L1213) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1210-L1212)

lib/solady/src/utils/FixedPointMathLib.sol#L1208-L1213


 - [ ] ID-96
[StorageSlot.getAddressSlot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L66-L70) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L67-L69)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L66-L70


 - [ ] ID-97
[SafeTransferLib.safeApproveWithRetry(address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L355-L382) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L357-L381)

lib/solady/src/utils/SafeTransferLib.sol#L355-L382


 - [ ] ID-98
[ERC20.permit(address,address,uint256,uint256,uint8,bytes32,bytes32)](lib/solady/src/tokens/ERC20.sol#L389-L469) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L400-L406)
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L413-L468)

lib/solady/src/tokens/ERC20.sol#L389-L469


 - [ ] ID-99
[FixedPointMathLib.lambertW0Wad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L353-L434) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L368-L377)
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L381-L386)
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L391-L394)
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L399-L401)
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L408-L412)
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L417-L419)
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L425-L427)
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L430-L432)

lib/solady/src/utils/FixedPointMathLib.sol#L353-L434


 - [ ] ID-100
[ERC20._incrementNonce(address)](lib/solady/src/tokens/ERC20.sol#L363-L371) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L365-L370)

lib/solady/src/tokens/ERC20.sol#L363-L371


 - [ ] ID-101
[FixedPointMathLib.log2Up(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L882-L888) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L885-L887)

lib/solady/src/utils/FixedPointMathLib.sol#L882-L888


 - [ ] ID-102
[SafeTransferLib.forceSafeTransferETH(address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L137-L151) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L139-L150)

lib/solady/src/utils/SafeTransferLib.sol#L137-L151


 - [ ] ID-103
[OwnableRoles._rolesFromOrdinals(uint8[])](lib/solady/src/auth/OwnableRoles.sol#L161-L170) uses assembly
	- [INLINE ASM](lib/solady/src/auth/OwnableRoles.sol#L163-L169)

lib/solady/src/auth/OwnableRoles.sol#L161-L170


 - [ ] ID-104
[OwnableRoles._checkOwnerOrRoles(uint256)](lib/solady/src/auth/OwnableRoles.sol#L116-L133) uses assembly
	- [INLINE ASM](lib/solady/src/auth/OwnableRoles.sol#L118-L132)

lib/solady/src/auth/OwnableRoles.sol#L116-L133


 - [ ] ID-105
[RewardsTrackerStorage.getRewardPool(address)](contracts/launchpad/libraries/RewardsTracker.sol#L242-L247) uses assembly
	- [INLINE ASM](contracts/launchpad/libraries/RewardsTracker.sol#L244-L246)

contracts/launchpad/libraries/RewardsTracker.sol#L242-L247


 - [ ] ID-106
[FixedPointMathLib.lnWad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L277-L347) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L279-L346)

lib/solady/src/utils/FixedPointMathLib.sol#L277-L347


 - [ ] ID-107
[FixedPointMathLib.ternary(bool,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L665-L670) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L667-L669)

lib/solady/src/utils/FixedPointMathLib.sol#L665-L670


 - [ ] ID-108
[RedBlackTreeLib._end(RedBlackTreeLib.Tree,uint256)](lib/solady/src/utils/RedBlackTreeLib.sol#L299-L314) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L302-L312)

lib/solady/src/utils/RedBlackTreeLib.sol#L299-L314


 - [ ] ID-109
[Ownable.owner()](lib/solady/src/auth/Ownable.sol#L245-L250) uses assembly
	- [INLINE ASM](lib/solady/src/auth/Ownable.sol#L247-L249)

lib/solady/src/auth/Ownable.sol#L245-L250


 - [ ] ID-110
[FixedPointMathLib.clamp(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L1084-L1094) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1090-L1093)

lib/solady/src/utils/FixedPointMathLib.sol#L1084-L1094


 - [ ] ID-111
[FixedPointMathLib.fullMulDiv(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L455-L512) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L457-L511)

lib/solady/src/utils/FixedPointMathLib.sol#L455-L512


 - [ ] ID-112
[RedBlackTreeLib._pack(uint256,uint256)](lib/solady/src/utils/RedBlackTreeLib.sol#L291-L296) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L293-L295)

lib/solady/src/utils/RedBlackTreeLib.sol#L291-L296


 - [ ] ID-113
[FixedPointMathLib.mulWad(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L64-L76) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L66-L75)

lib/solady/src/utils/FixedPointMathLib.sol#L64-L76


 - [ ] ID-114
[FixedPointMathLib.divUp(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L645-L654) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L647-L653)

lib/solady/src/utils/FixedPointMathLib.sol#L645-L654


 - [ ] ID-115
[ERC20._transfer(address,address,uint256)](lib/solady/src/tokens/ERC20.sol#L559-L587) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L562-L585)

lib/solady/src/tokens/ERC20.sol#L559-L587


 - [ ] ID-116
[Proxy._delegate(address)](lib/openzeppelin-contracts/contracts/proxy/Proxy.sol#L22-L45) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/proxy/Proxy.sol#L23-L44)

lib/openzeppelin-contracts/contracts/proxy/Proxy.sol#L22-L45


 - [ ] ID-117
[ERC20.totalSupply()](lib/solady/src/tokens/ERC20.sol#L147-L152) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L149-L151)

lib/solady/src/tokens/ERC20.sol#L147-L152


 - [ ] ID-118
[FixedPointMathLib.mulDivUp(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L610-L621) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L612-L620)

lib/solady/src/utils/FixedPointMathLib.sol#L610-L621


 - [ ] ID-119
[RedBlackTreeLib._update.asm_0.remove()](lib/solady/src/utils/RedBlackTreeLib.sol#L547-L651) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L547-L651)

lib/solady/src/utils/RedBlackTreeLib.sol#L547-L651


 - [ ] ID-120
[StorageSlot.getInt256Slot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L102-L106) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L103-L105)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L102-L106


 - [ ] ID-121
[SafeTransferLib.totalSupply(address)](lib/solady/src/utils/SafeTransferLib.sol#L404-L416) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L406-L415)

lib/solady/src/utils/SafeTransferLib.sol#L404-L416


 - [ ] ID-122
[SafeTransferLib.balanceOf(address,address)](lib/solady/src/utils/SafeTransferLib.sol#L386-L400) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L388-L399)

lib/solady/src/utils/SafeTransferLib.sol#L386-L400


 - [ ] ID-123
[FixedPointMathLib.log256(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L927-L936) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L929-L935)

lib/solady/src/utils/FixedPointMathLib.sol#L927-L936


 - [ ] ID-124
[SafeTransferLib.simplePermit2(address,address,address,uint256,uint256,uint8,bytes32,bytes32)](lib/solady/src/utils/SafeTransferLib.sol#L515-L565) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L526-L564)

lib/solady/src/utils/SafeTransferLib.sol#L515-L565


 - [ ] ID-125
[ERC20.DOMAIN_SEPARATOR()](lib/solady/src/tokens/ERC20.sol#L472-L487) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L478-L486)

lib/solady/src/tokens/ERC20.sol#L472-L487


 - [ ] ID-126
[RedBlackTreeLib._update.asm_0.rotate()](lib/solady/src/utils/RedBlackTreeLib.sol#L362-L392) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L362-L392)

lib/solady/src/utils/RedBlackTreeLib.sol#L362-L392


 - [ ] ID-127
[Ownable._checkOwner()](lib/solady/src/auth/Ownable.sol#L151-L160) uses assembly
	- [INLINE ASM](lib/solady/src/auth/Ownable.sol#L153-L159)

lib/solady/src/auth/Ownable.sol#L151-L160


 - [ ] ID-128
[ERC20._burn(address,uint256)](lib/solady/src/tokens/ERC20.sol#L529-L552) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L532-L550)

lib/solady/src/tokens/ERC20.sol#L529-L552


 - [ ] ID-129
[FixedPointMathLib.rawAddMod(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L1240-L1245) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1242-L1244)

lib/solady/src/utils/FixedPointMathLib.sol#L1240-L1245


 - [ ] ID-130
[OwnableRoles._updateRoles(address,uint256,bool)](lib/solady/src/auth/OwnableRoles.sol#L64-L83) uses assembly
	- [INLINE ASM](lib/solady/src/auth/OwnableRoles.sol#L66-L82)

lib/solady/src/auth/OwnableRoles.sol#L64-L83


 - [ ] ID-131
[RedBlackTreeLib._nodes(RedBlackTreeLib.Tree)](lib/solady/src/utils/RedBlackTreeLib.sol#L670-L677) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L672-L676)

lib/solady/src/utils/RedBlackTreeLib.sol#L670-L677


 - [ ] ID-132
[FixedPointMathLib.dist(int256,int256)](lib/solady/src/utils/FixedPointMathLib.sol#L1044-L1049) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1046-L1048)

lib/solady/src/utils/FixedPointMathLib.sol#L1044-L1049


 - [ ] ID-133
[OwnableUpgradeable._getOwnableStorage()](lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L30-L34) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L31-L33)

lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L30-L34


 - [ ] ID-134
[Ownable2StepUpgradeable._getOwnable2StepStorage()](lib/openzeppelin-contracts-upgradeable/contracts/access/Ownable2StepUpgradeable.sol#L35-L39) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/contracts/access/Ownable2StepUpgradeable.sol#L36-L38)

lib/openzeppelin-contracts-upgradeable/contracts/access/Ownable2StepUpgradeable.sol#L35-L39


 - [ ] ID-135
[Ownable.ownershipHandoverExpiresAt(address)](lib/solady/src/auth/Ownable.sol#L253-L267) uses assembly
	- [INLINE ASM](lib/solady/src/auth/Ownable.sol#L260-L266)

lib/solady/src/auth/Ownable.sol#L253-L267


 - [ ] ID-136
[RedBlackTreeLib._update.asm_0.insert()](lib/solady/src/utils/RedBlackTreeLib.sol#L394-L479) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L394-L479)

lib/solady/src/utils/RedBlackTreeLib.sol#L394-L479


 - [ ] ID-137
[FixedPointMathLib.rawSMod(int256,int256)](lib/solady/src/utils/FixedPointMathLib.sol#L1232-L1237) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1234-L1236)

lib/solady/src/utils/FixedPointMathLib.sol#L1232-L1237


 - [ ] ID-138
[StorageSlot.getBytesSlot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L129-L133) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L130-L132)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L129-L133


 - [ ] ID-139
[SafeTransferLib.forceSafeTransferETH(address,uint256,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L107-L121) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L109-L120)

lib/solady/src/utils/SafeTransferLib.sol#L107-L121


 - [ ] ID-140
[SafeTransferLib.safeTransferAll(address,address)](lib/solady/src/utils/SafeTransferLib.sol#L302-L330) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L304-L329)

lib/solady/src/utils/SafeTransferLib.sol#L302-L330


 - [ ] ID-141
[FixedPointMathLib.rawMulWadUp(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L125-L130) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L127-L129)

lib/solady/src/utils/FixedPointMathLib.sol#L125-L130


 - [ ] ID-142
[ERC20.balanceOf(address)](lib/solady/src/tokens/ERC20.sol#L155-L162) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L157-L161)

lib/solady/src/tokens/ERC20.sol#L155-L162


 - [ ] ID-143
[Ownable.requestOwnershipHandover()](lib/solady/src/auth/Ownable.sol#L192-L205) uses assembly
	- [INLINE ASM](lib/solady/src/auth/Ownable.sol#L196-L203)

lib/solady/src/auth/Ownable.sol#L192-L205


 - [ ] ID-144
[Ownable._setOwner(address)](lib/solady/src/auth/Ownable.sol#L124-L148) uses assembly
	- [INLINE ASM](lib/solady/src/auth/Ownable.sol#L127-L135)
	- [INLINE ASM](lib/solady/src/auth/Ownable.sol#L138-L146)

lib/solady/src/auth/Ownable.sol#L124-L148


 - [ ] ID-145
[RedBlackTreeLib._step(bytes32,uint256,uint256)](lib/solady/src/utils/RedBlackTreeLib.sol#L317-L345) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L321-L343)

lib/solady/src/utils/RedBlackTreeLib.sol#L317-L345


 - [ ] ID-146
[FixedPointMathLib.rawSDiv(int256,int256)](lib/solady/src/utils/FixedPointMathLib.sol#L1216-L1221) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1218-L1220)

lib/solady/src/utils/FixedPointMathLib.sol#L1216-L1221


 - [ ] ID-147
[FixedPointMathLib.gcd(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L1106-L1115) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1108-L1114)

lib/solady/src/utils/FixedPointMathLib.sol#L1106-L1115


 - [ ] ID-148
[FixedPointMathLib.log256Up(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L940-L946) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L943-L945)

lib/solady/src/utils/FixedPointMathLib.sol#L940-L946


 - [ ] ID-149
[RedBlackTreeLib.size(RedBlackTreeLib.Tree)](lib/solady/src/utils/RedBlackTreeLib.sol#L99-L105) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L102-L104)

lib/solady/src/utils/RedBlackTreeLib.sol#L99-L105


 - [ ] ID-150
[SafeTransferLib.forceSafeTransferAllETH(address)](lib/solady/src/utils/SafeTransferLib.sol#L154-L165) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L156-L164)

lib/solady/src/utils/SafeTransferLib.sol#L154-L165


 - [ ] ID-151
[FixedPointMathLib.ternary(bool,bytes32,bytes32)](lib/solady/src/utils/FixedPointMathLib.sol#L673-L678) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L675-L677)

lib/solady/src/utils/FixedPointMathLib.sol#L673-L678


 - [ ] ID-152
[StorageSlot.getStringSlot(string)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L120-L124) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L121-L123)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L120-L124


 - [ ] ID-153
[RedBlackTreeLib.values(RedBlackTreeLib.Tree)](lib/solady/src/utils/RedBlackTreeLib.sol#L110-L133) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L113-L132)

lib/solady/src/utils/RedBlackTreeLib.sol#L110-L133


 - [ ] ID-154
[StorageSlot.getBytes32Slot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L84-L88) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L85-L87)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L84-L88


 - [ ] ID-155
[RedBlackTreeLib._update.asm_0.setKey()](lib/solady/src/utils/RedBlackTreeLib.sol#L358-L360) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L358-L360)

lib/solady/src/utils/RedBlackTreeLib.sol#L358-L360


 - [ ] ID-156
[RedBlackTreeLib._update.asm_0.removeFixup()](lib/solady/src/utils/RedBlackTreeLib.sol#L481-L534) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L481-L534)

lib/solady/src/utils/RedBlackTreeLib.sol#L481-L534


 - [ ] ID-157
[ERC20.transfer(address,uint256)](lib/solady/src/tokens/ERC20.sol#L217-L246) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L220-L243)

lib/solady/src/tokens/ERC20.sol#L217-L246


 - [ ] ID-158
[BookLib.getOrdersPaginated(Book,Order,uint256)](contracts/clob/types/Book.sol#L211-L239) uses assembly
	- [INLINE ASM](contracts/clob/types/Book.sol#L233-L236)

contracts/clob/types/Book.sol#L211-L239


 - [ ] ID-159
[SafeTransferLib.safeTransferAllFrom(address,address,address)](lib/solady/src/utils/SafeTransferLib.sol#L245-L278) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L250-L277)

lib/solady/src/utils/SafeTransferLib.sol#L245-L278


 - [ ] ID-160
[StorageSlot.getBytesSlot(bytes)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L138-L142) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L139-L141)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L138-L142


 - [ ] ID-161
[ERC20.allowance(address,address)](lib/solady/src/tokens/ERC20.sol#L165-L181) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L175-L180)

lib/solady/src/tokens/ERC20.sol#L165-L181


 - [ ] ID-162
[SafeTransferLib.permit2TransferFrom(address,address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L431-L456) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L435-L455)

lib/solady/src/utils/SafeTransferLib.sol#L431-L456


 - [ ] ID-163
[SafeTransferLib.forceSafeTransferAllETH(address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L124-L134) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L126-L133)

lib/solady/src/utils/SafeTransferLib.sol#L124-L134


 - [ ] ID-164
[ERC20._mint(address,uint256)](lib/solady/src/tokens/ERC20.sol#L496-L520) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L499-L518)

lib/solady/src/tokens/ERC20.sol#L496-L520


 - [ ] ID-165
[RedBlackTreeLib._update(uint256,uint256,uint256,uint256,uint256)](lib/solady/src/utils/RedBlackTreeLib.sol#L348-L667) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L353-L666)

lib/solady/src/utils/RedBlackTreeLib.sol#L348-L667


 - [ ] ID-166
[FixedPointMathLib.packSci(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L995-L1005) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L998-L1004)

lib/solady/src/utils/FixedPointMathLib.sol#L995-L1005


 - [ ] ID-167
[FixedPointMathLib.rawMulWad(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L93-L98) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L95-L97)

lib/solady/src/utils/FixedPointMathLib.sol#L93-L98


 - [ ] ID-168
[FixedPointMathLib.sDivWad(int256,int256)](lib/solady/src/utils/FixedPointMathLib.sol#L146-L157) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L148-L156)

lib/solady/src/utils/FixedPointMathLib.sol#L146-L157


 - [ ] ID-169
[Initializable._disableInitializers()](lib/solady/src/utils/Initializable.sol#L148-L166) uses assembly
	- [INLINE ASM](lib/solady/src/utils/Initializable.sol#L151-L165)

lib/solady/src/utils/Initializable.sol#L148-L166


 - [ ] ID-170
[FixedPointMathLib.max(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L1068-L1073) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1070-L1072)

lib/solady/src/utils/FixedPointMathLib.sol#L1068-L1073


 - [ ] ID-171
[RedBlackTreeLib.value(bytes32)](lib/solady/src/utils/RedBlackTreeLib.sol#L236-L244) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L239-L243)

lib/solady/src/utils/RedBlackTreeLib.sol#L236-L244


 - [ ] ID-172
[FixedPointMathLib.rawSMulWad(int256,int256)](lib/solady/src/utils/FixedPointMathLib.sol#L101-L106) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L103-L105)

lib/solady/src/utils/FixedPointMathLib.sol#L101-L106


 - [ ] ID-173
[RedBlackTreeLib._find(RedBlackTreeLib.Tree,uint256)](lib/solady/src/utils/RedBlackTreeLib.sol#L680-L707) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L687-L706)

lib/solady/src/utils/RedBlackTreeLib.sol#L680-L707


 - [ ] ID-174
[FixedPointMathLib.sMulWad(int256,int256)](lib/solady/src/utils/FixedPointMathLib.sol#L79-L90) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L81-L89)

lib/solady/src/utils/FixedPointMathLib.sol#L79-L90


 - [ ] ID-175
[FixedPointMathLib.log10(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L892-L913) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L894-L912)

lib/solady/src/utils/FixedPointMathLib.sol#L892-L913


 - [ ] ID-176
[ERC20._spendAllowance(address,address,uint256)](lib/solady/src/tokens/ERC20.sol#L594-L617) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L599-L616)

lib/solady/src/tokens/ERC20.sol#L594-L617


 - [ ] ID-177
[Initializable._checkInitializing()](lib/solady/src/utils/Initializable.sol#L130-L139) uses assembly
	- [INLINE ASM](lib/solady/src/utils/Initializable.sol#L133-L138)

lib/solady/src/utils/Initializable.sol#L130-L139


 - [ ] ID-178
[Initializable._getInitializableStorage()](lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L223-L227) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L224-L226)

lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L223-L227


 - [ ] ID-179
[SafeTransferLib.trySafeTransferAllETH(address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L179-L187) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L184-L186)

lib/solady/src/utils/SafeTransferLib.sol#L179-L187


 - [ ] ID-180
[Address._revert(bytes)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L138-L149) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/Address.sol#L142-L145)

lib/openzeppelin-contracts/contracts/utils/Address.sol#L138-L149


 - [ ] ID-181
[OwnableRoles._checkRoles(uint256)](lib/solady/src/auth/OwnableRoles.sol#L98-L111) uses assembly
	- [INLINE ASM](lib/solady/src/auth/OwnableRoles.sol#L100-L110)

lib/solady/src/auth/OwnableRoles.sol#L98-L111


 - [ ] ID-182
[StorageSlot.getBooleanSlot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L75-L79) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L76-L78)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L75-L79


 - [ ] ID-183
[FixedPointMathLib.cbrtWad(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L824-L848) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L831-L847)

lib/solady/src/utils/FixedPointMathLib.sol#L824-L848


 - [ ] ID-184
[SafeTransferLib.safeTransferAllETH(address)](lib/solady/src/utils/SafeTransferLib.sol#L95-L104) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L97-L103)

lib/solady/src/utils/SafeTransferLib.sol#L95-L104


 - [ ] ID-185
[StorageSlot.getStringSlot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L111-L115) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L112-L114)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L111-L115


 - [ ] ID-186
[SafeTransferLib.trySafeTransferETH(address,uint256,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L168-L176) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L173-L175)

lib/solady/src/utils/SafeTransferLib.sol#L168-L176


 - [ ] ID-187
[FixedPointMathLib.fullMulDivN(uint256,uint256,uint8)](lib/solady/src/utils/FixedPointMathLib.sol#L566-L591) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L568-L590)

lib/solady/src/utils/FixedPointMathLib.sol#L566-L591


 - [ ] ID-188
[OwnableRoles.rolesOf(address)](lib/solady/src/auth/OwnableRoles.sol#L228-L237) uses assembly
	- [INLINE ASM](lib/solady/src/auth/OwnableRoles.sol#L230-L236)

lib/solady/src/auth/OwnableRoles.sol#L228-L237


 - [ ] ID-189
[OwnableRoles._ordinalsFromRoles(uint256)](lib/solady/src/auth/OwnableRoles.sol#L176-L199) uses assembly
	- [INLINE ASM](lib/solady/src/auth/OwnableRoles.sol#L178-L198)

lib/solady/src/auth/OwnableRoles.sol#L176-L199


 - [ ] ID-190
[ERC20.nonces(address)](lib/solady/src/tokens/ERC20.sol#L375-L383) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L377-L382)

lib/solady/src/tokens/ERC20.sol#L375-L383


 - [ ] ID-191
[FixedPointMathLib.fullMulDivUnchecked(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L517-L542) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L523-L541)

lib/solady/src/utils/FixedPointMathLib.sol#L517-L542


 - [ ] ID-192
[SafeTransferLib.safeTransferFrom(address,address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L198-L216) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L200-L215)

lib/solady/src/utils/SafeTransferLib.sol#L198-L216


 - [ ] ID-193
[SafeTransferLib.safeTransfer(address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L282-L298) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L284-L297)

lib/solady/src/utils/SafeTransferLib.sol#L282-L298


 - [ ] ID-194
[ERC20.approve(address,uint256)](lib/solady/src/tokens/ERC20.sol#L186-L209) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L189-L195)
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L198-L207)

lib/solady/src/tokens/ERC20.sol#L186-L209


 - [ ] ID-195
[RedBlackTreeLib._revert(uint256)](lib/solady/src/utils/RedBlackTreeLib.sol#L710-L716) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L712-L715)

lib/solady/src/utils/RedBlackTreeLib.sol#L710-L716


 - [ ] ID-196
[FixedPointMathLib.cbrt(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L785-L806) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L787-L805)

lib/solady/src/utils/FixedPointMathLib.sol#L785-L806


 - [ ] ID-197
[Ownable.transferOwnership(address)](lib/solady/src/auth/Ownable.sol#L174-L183) uses assembly
	- [INLINE ASM](lib/solady/src/auth/Ownable.sol#L176-L181)

lib/solady/src/auth/Ownable.sol#L174-L183


 - [ ] ID-198
[RedBlackTreeLib._update.asm_0.replaceParent()](lib/solady/src/utils/RedBlackTreeLib.sol#L536-L545) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L536-L545)

lib/solady/src/utils/RedBlackTreeLib.sol#L536-L545


 - [ ] ID-199
[FixedPointMathLib.rawMulMod(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L1248-L1253) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1250-L1252)

lib/solady/src/utils/FixedPointMathLib.sol#L1248-L1253


 - [ ] ID-200
[ERC20.transferFrom(address,address,uint256)](lib/solady/src/tokens/ERC20.sol#L257-L347) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L262-L302)
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L305-L343)

lib/solady/src/tokens/ERC20.sol#L257-L347


 - [ ] ID-201
[FixedPointMathLib.ternary(bool,address,address)](lib/solady/src/utils/FixedPointMathLib.sol#L681-L686) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L683-L685)

lib/solady/src/utils/FixedPointMathLib.sol#L681-L686


 - [ ] ID-202
[FixedPointMathLib.min(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L1052-L1057) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1054-L1056)

lib/solady/src/utils/FixedPointMathLib.sol#L1052-L1057


 - [ ] ID-203
[FixedPointMathLib.divWad(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L133-L143) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L135-L142)

lib/solady/src/utils/FixedPointMathLib.sol#L133-L143


 - [ ] ID-204
[SafeTransferLib.safeApprove(address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L334-L349) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L336-L348)

lib/solady/src/utils/SafeTransferLib.sol#L334-L349


 - [ ] ID-205
[FixedPointMathLib.rawDivWadUp(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L189-L194) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L191-L193)

lib/solady/src/utils/FixedPointMathLib.sol#L189-L194


 - [ ] ID-206
[FixedPointMathLib.log10Up(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L917-L923) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L920-L922)

lib/solady/src/utils/FixedPointMathLib.sol#L917-L923


 - [ ] ID-207
[FixedPointMathLib.fullMulDivUp(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L548-L560) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L551-L559)

lib/solady/src/utils/FixedPointMathLib.sol#L548-L560


 - [ ] ID-208
[FixedPointMathLib.clamp(int256,int256,int256)](lib/solady/src/utils/FixedPointMathLib.sol#L1097-L1103) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1099-L1102)

lib/solady/src/utils/FixedPointMathLib.sol#L1097-L1103


 - [ ] ID-209
[FixedPointMathLib.rpow(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L690-L724) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L692-L723)

lib/solady/src/utils/FixedPointMathLib.sol#L690-L724


 - [ ] ID-210
[OwnableRoles._setRoles(address,uint256)](lib/solady/src/auth/OwnableRoles.sol#L49-L59) uses assembly
	- [INLINE ASM](lib/solady/src/auth/OwnableRoles.sol#L51-L58)

lib/solady/src/auth/OwnableRoles.sol#L49-L59


 - [ ] ID-211
[ERC20._approve(address,address,uint256)](lib/solady/src/tokens/ERC20.sol#L622-L644) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L625-L631)
	- [INLINE ASM](lib/solady/src/tokens/ERC20.sol#L634-L643)

lib/solady/src/tokens/ERC20.sol#L622-L644


 - [ ] ID-212
[SafeTransferLib.permit2(address,address,address,uint256,uint256,uint8,bytes32,bytes32)](lib/solady/src/utils/SafeTransferLib.sol#L461-L512) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L473-L510)

lib/solady/src/utils/SafeTransferLib.sol#L461-L512


 - [ ] ID-213
[FixedPointMathLib.sqrtWad(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L809-L819) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L816-L818)

lib/solady/src/utils/FixedPointMathLib.sol#L809-L819


 - [ ] ID-214
[FixedPointMathLib.factorial(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L851-L861) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L853-L860)

lib/solady/src/utils/FixedPointMathLib.sol#L851-L861


 - [ ] ID-215
[SafeCastLib._revertOverflow()](lib/solady/src/utils/SafeCastLib.sol#L568-L576) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeCastLib.sol#L570-L575)

lib/solady/src/utils/SafeCastLib.sol#L568-L576


 - [ ] ID-216
[Ownable._initializeOwner(address)](lib/solady/src/auth/Ownable.sol#L94-L121) uses assembly
	- [INLINE ASM](lib/solady/src/auth/Ownable.sol#L97-L109)
	- [INLINE ASM](lib/solady/src/auth/Ownable.sol#L112-L119)

lib/solady/src/auth/Ownable.sol#L94-L121


 - [ ] ID-217
[FixedPointMathLib.log2(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L866-L878) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L868-L877)

lib/solady/src/utils/FixedPointMathLib.sol#L866-L878


 - [ ] ID-218
[OwnableRoles._checkRolesOrOwner(uint256)](lib/solady/src/auth/OwnableRoles.sol#L138-L155) uses assembly
	- [INLINE ASM](lib/solady/src/auth/OwnableRoles.sol#L140-L154)

lib/solady/src/auth/OwnableRoles.sol#L138-L155


 - [ ] ID-219
[FixedPointMathLib.max(int256,int256)](lib/solady/src/utils/FixedPointMathLib.sol#L1076-L1081) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1078-L1080)

lib/solady/src/utils/FixedPointMathLib.sol#L1076-L1081


 - [ ] ID-220
[FixedPointMathLib.expWad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L207-L272) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L214-L221)
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L253-L258)

lib/solady/src/utils/FixedPointMathLib.sol#L207-L272


 - [ ] ID-221
[StorageSlot.getUint256Slot(bytes32)](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L93-L97) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L94-L96)

lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L93-L97


 - [ ] ID-222
[Ownable.completeOwnershipHandover(address)](lib/solady/src/auth/Ownable.sol#L222-L238) uses assembly
	- [INLINE ASM](lib/solady/src/auth/Ownable.sol#L224-L236)

lib/solady/src/auth/Ownable.sol#L222-L238


 - [ ] ID-223
[FixedPointMathLib.invMod(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L624-L641) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L626-L640)

lib/solady/src/utils/FixedPointMathLib.sol#L624-L641


 - [ ] ID-224
[RedBlackTreeLib.values.asm_0.visit()](lib/solady/src/utils/RedBlackTreeLib.sol#L114-L124) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L114-L124)

lib/solady/src/utils/RedBlackTreeLib.sol#L114-L124


 - [ ] ID-225
[FixedPointMathLib.divWadUp(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L176-L186) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L178-L185)

lib/solady/src/utils/FixedPointMathLib.sol#L176-L186


 - [ ] ID-226
[FixedPointMathLib.rawSDivWad(int256,int256)](lib/solady/src/utils/FixedPointMathLib.sol#L168-L173) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L170-L172)

lib/solady/src/utils/FixedPointMathLib.sol#L168-L173


 - [ ] ID-227
[FixedPointMathLib.mulDiv(uint256,uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L595-L606) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L597-L605)

lib/solady/src/utils/FixedPointMathLib.sol#L595-L606


 - [ ] ID-228
[FixedPointMathLib.rawMod(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L1224-L1229) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L1226-L1228)

lib/solady/src/utils/FixedPointMathLib.sol#L1224-L1229


 - [ ] ID-229
[FixedPointMathLib.sqrt(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L727-L778) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L729-L777)

lib/solady/src/utils/FixedPointMathLib.sol#L727-L778


 - [ ] ID-230
[Ownable.cancelOwnershipHandover()](lib/solady/src/auth/Ownable.sol#L208-L218) uses assembly
	- [INLINE ASM](lib/solady/src/auth/Ownable.sol#L210-L217)

lib/solady/src/auth/Ownable.sol#L208-L218


 - [ ] ID-231
[Initializable._isInitializing()](lib/solady/src/utils/Initializable.sol#L178-L184) uses assembly
	- [INLINE ASM](lib/solady/src/utils/Initializable.sol#L181-L183)

lib/solady/src/utils/Initializable.sol#L178-L184


 - [ ] ID-232
[FixedPointMathLib.zeroFloorSub(uint256,uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L657-L662) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L659-L661)

lib/solady/src/utils/FixedPointMathLib.sol#L657-L662


 - [ ] ID-233
[WETH.withdraw(uint256)](lib/solady/src/tokens/WETH.sol#L42-L52) uses assembly
	- [INLINE ASM](lib/solady/src/tokens/WETH.sol#L45-L51)

lib/solady/src/tokens/WETH.sol#L42-L52


 - [ ] ID-234
[FixedPointMathLib.sci(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L950-L985) uses assembly
	- [INLINE ASM](lib/solady/src/utils/FixedPointMathLib.sol#L952-L984)

lib/solady/src/utils/FixedPointMathLib.sol#L950-L985


 - [ ] ID-235
[SafeTransferLib.safeTransferETH(address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L84-L92) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L86-L91)

lib/solady/src/utils/SafeTransferLib.sol#L84-L92


 - [ ] ID-236
[SafeTransferLib.trySafeTransferFrom(address,address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L221-L239) uses assembly
	- [INLINE ASM](lib/solady/src/utils/SafeTransferLib.sol#L226-L238)

lib/solady/src/utils/SafeTransferLib.sol#L221-L239


 - [ ] ID-237
[RedBlackTreeLib._unpack(bytes32)](lib/solady/src/utils/RedBlackTreeLib.sol#L282-L288) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L284-L287)

lib/solady/src/utils/RedBlackTreeLib.sol#L282-L288


 - [ ] ID-238
[RedBlackTreeLib._update.asm_0.getKey()](lib/solady/src/utils/RedBlackTreeLib.sol#L354-L356) uses assembly
	- [INLINE ASM](lib/solady/src/utils/RedBlackTreeLib.sol#L354-L356)

lib/solady/src/utils/RedBlackTreeLib.sol#L354-L356


## pragma
Impact: Informational
Confidence: High
 - [ ] ID-239
8 different versions of Solidity are used:
	- Version constraint 0.8.27 is used by:
		-[0.8.27](contracts/account-manager/AccountManager.sol#L2)
		-[0.8.27](contracts/account-manager/IAccountManager.sol#L2)
		-[0.8.27](contracts/clob/CLOB.sol#L2)
		-[0.8.27](contracts/clob/CLOBManager.sol#L2)
		-[0.8.27](contracts/clob/ILimitLens.sol#L2)
		-[0.8.27](contracts/clob/types/Book.sol#L2)
		-[0.8.27](contracts/clob/types/FeeData.sol#L2)
		-[0.8.27](contracts/clob/types/Order.sol#L2)
		-[0.8.27](contracts/clob/types/RedBlackTree.sol#L2)
		-[0.8.27](contracts/clob/types/Roles.sol#L2)
		-[0.8.27](contracts/launchpad/Distributor.sol#L2)
		-[0.8.27](contracts/launchpad/LaunchToken.sol#L2)
		-[0.8.27](contracts/launchpad/LaunchpadLPVault.sol#L2)
		-[0.8.27](contracts/launchpad/interfaces/IBondingCurveMinimal.sol#L2)
		-[0.8.27](contracts/launchpad/interfaces/IDistributor.sol#L1)
		-[0.8.27](contracts/launchpad/interfaces/IGTELaunchpadV2Pair.sol#L2)
		-[0.8.27](contracts/launchpad/interfaces/ILaunchpad.sol#L2)
		-[0.8.27](contracts/launchpad/interfaces/ISimpleLaunchpad.sol#L1)
		-[0.8.27](contracts/launchpad/interfaces/IUniV2Factory.sol#L2)
		-[0.8.27](contracts/launchpad/interfaces/IUniswapV2FactoryMinimal.sol#L1)
		-[0.8.27](contracts/launchpad/interfaces/IUniswapV2Pair.sol#L1)
		-[0.8.27](contracts/launchpad/interfaces/IUniswapV2RouterMinimal.sol#L2)
		-[0.8.27](contracts/launchpad/libraries/RewardsTracker.sol#L2)
		-[0.8.27](contracts/utils/Operator.sol#L2)
		-[0.8.27](contracts/utils/types/EventNonce.sol#L2)
		-[0.8.27](contracts/utils/types/OperatorHelperLib.sol#L2)
	- Version constraint ^0.8.27 is used by:
		-[^0.8.27](contracts/clob/ICLOB.sol#L2)
		-[^0.8.27](contracts/clob/ICLOBManager.sol#L2)
		-[^0.8.27](contracts/clob/types/TransientMakerData.sol#L2)
		-[^0.8.27](contracts/router/GTERouter.sol#L2)
		-[^0.8.27](contracts/utils/interfaces/IOperator.sol#L2)
	- Version constraint =0.8.27 is used by:
		-[=0.8.27](contracts/router/interfaces/IUniswapV2Router01.sol#L2)
	- Version constraint ^0.8.20 is used by:
		-[^0.8.20](lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts/contracts/proxy/Proxy.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts/contracts/proxy/beacon/BeaconProxy.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts/contracts/proxy/beacon/IBeacon.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts/contracts/utils/Address.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts/contracts/utils/Errors.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L5)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/access/Ownable2StepUpgradeable.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L4)
	- Version constraint ^0.8.21 is used by:
		-[^0.8.21](lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L4)
	- Version constraint ^0.8.0 is used by:
		-[^0.8.0](lib/permit2/src/interfaces/IAllowanceTransfer.sol#L2)
		-[^0.8.0](lib/permit2/src/interfaces/IEIP712.sol#L2)
	- Version constraint ^0.8.4 is used by:
		-[^0.8.4](lib/solady/src/auth/Ownable.sol#L2)
		-[^0.8.4](lib/solady/src/auth/OwnableRoles.sol#L2)
		-[^0.8.4](lib/solady/src/tokens/ERC20.sol#L2)
		-[^0.8.4](lib/solady/src/tokens/WETH.sol#L2)
		-[^0.8.4](lib/solady/src/utils/FixedPointMathLib.sol#L2)
		-[^0.8.4](lib/solady/src/utils/Initializable.sol#L2)
		-[^0.8.4](lib/solady/src/utils/RedBlackTreeLib.sol#L2)
		-[^0.8.4](lib/solady/src/utils/SafeCastLib.sol#L2)
		-[^0.8.4](lib/solady/src/utils/SafeTransferLib.sol#L2)
	- Version constraint ^0.8.24 is used by:
		-[^0.8.24](lib/solady/src/utils/ReentrancyGuardTransient.sol#L2)

contracts/account-manager/AccountManager.sol#L2


## cyclomatic-complexity
Impact: Informational
Confidence: High
 - [ ] ID-240
[RedBlackTreeLib._update.asm_0.insert()](lib/solady/src/utils/RedBlackTreeLib.sol#L394-L479) has a high cyclomatic complexity (13).

lib/solady/src/utils/RedBlackTreeLib.sol#L394-L479


 - [ ] ID-241
[RedBlackTreeLib._update.asm_0.remove()](lib/solady/src/utils/RedBlackTreeLib.sol#L547-L651) has a high cyclomatic complexity (17).

lib/solady/src/utils/RedBlackTreeLib.sol#L547-L651


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-242
Version constraint ^0.8.4 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- DataLocationChangeInInternalOverride
	- NestedCalldataArrayAbiReencodingSizeValidation
	- SignedImmutables.
It is used by:
	- [^0.8.4](lib/solady/src/auth/Ownable.sol#L2)
	- [^0.8.4](lib/solady/src/auth/OwnableRoles.sol#L2)
	- [^0.8.4](lib/solady/src/tokens/ERC20.sol#L2)
	- [^0.8.4](lib/solady/src/tokens/WETH.sol#L2)
	- [^0.8.4](lib/solady/src/utils/FixedPointMathLib.sol#L2)
	- [^0.8.4](lib/solady/src/utils/Initializable.sol#L2)
	- [^0.8.4](lib/solady/src/utils/RedBlackTreeLib.sol#L2)
	- [^0.8.4](lib/solady/src/utils/SafeCastLib.sol#L2)
	- [^0.8.4](lib/solady/src/utils/SafeTransferLib.sol#L2)

lib/solady/src/auth/Ownable.sol#L2


 - [ ] ID-243
Version constraint ^0.8.21 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication.
It is used by:
	- [^0.8.21](lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L4)

lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L4


 - [ ] ID-244
Version constraint ^0.8.20 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess.
It is used by:
	- [^0.8.20](lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/proxy/Proxy.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/proxy/beacon/BeaconProxy.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/proxy/beacon/IBeacon.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/utils/Address.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/utils/Errors.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L5)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/access/Ownable2StepUpgradeable.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L4)

lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol#L4


 - [ ] ID-245
Version constraint ^0.8.0 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- DataLocationChangeInInternalOverride
	- NestedCalldataArrayAbiReencodingSizeValidation
	- SignedImmutables
	- ABIDecodeTwoDimensionalArrayMemory
	- KeccakCaching.
It is used by:
	- [^0.8.0](lib/permit2/src/interfaces/IAllowanceTransfer.sol#L2)
	- [^0.8.0](lib/permit2/src/interfaces/IEIP712.sol#L2)

lib/permit2/src/interfaces/IAllowanceTransfer.sol#L2


## incorrect-using-for
Impact: Informational
Confidence: High
 - [ ] ID-246
using-for statement at contracts/account-manager/AccountManager.sol#343 is incorrect - no matching function for AccountManagerStorage found in [AccountManagerStorageLib](contracts/account-manager/AccountManager.sol#L346-L361).

contracts/account-manager/AccountManager.sol#L346-L361


 - [ ] ID-247
using-for statement at contracts/utils/Operator.sol#19 is incorrect - no matching function for OperatorStorage found in [OperatorStorageLib](contracts/utils/Operator.sol#L22-L36).

contracts/utils/Operator.sol#L22-L36


 - [ ] ID-248
using-for statement at contracts/clob/CLOBManager.sol#31 is incorrect - no matching function for CLOBManagerStorage found in [CLOBManagerStorageLib](contracts/clob/CLOBManager.sol#L34-L48).

contracts/clob/CLOBManager.sol#L34-L48


## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-249
Low level call in [Address.functionDelegateCall(address,bytes)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L96-L99):
	- [(success,returndata) = target.delegatecall(data)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L97)

lib/openzeppelin-contracts/contracts/utils/Address.sol#L96-L99


 - [ ] ID-250
Low level call in [Address.functionCallWithValue(address,bytes,uint256)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L75-L81):
	- [(success,returndata) = target.call{value: value}(data)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L79)

lib/openzeppelin-contracts/contracts/utils/Address.sol#L75-L81


 - [ ] ID-251
Low level call in [Address.sendValue(address,uint256)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L33-L42):
	- [(success,None) = recipient.call{value: amount}()](lib/openzeppelin-contracts/contracts/utils/Address.sol#L38)

lib/openzeppelin-contracts/contracts/utils/Address.sol#L33-L42


 - [ ] ID-252
Low level call in [Address.functionStaticCall(address,bytes)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L87-L90):
	- [(success,returndata) = target.staticcall(data)](lib/openzeppelin-contracts/contracts/utils/Address.sol#L88)

lib/openzeppelin-contracts/contracts/utils/Address.sol#L87-L90


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-253
Parameter [RedBlackTreeLib._update.asm_0.replaceParent().b___update_asm_0_replaceParent](lib/solady/src/utils/RedBlackTreeLib.sol#L536) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L536


 - [ ] ID-254
Constant [Ownable2StepUpgradeable.Ownable2StepStorageLocation](lib/openzeppelin-contracts-upgradeable/contracts/access/Ownable2StepUpgradeable.sol#L33) is not in UPPER_CASE_WITH_UNDERSCORES

lib/openzeppelin-contracts-upgradeable/contracts/access/Ownable2StepUpgradeable.sol#L33


 - [ ] ID-255
Parameter [RedBlackTreeLib._update.asm_0.remove().nodes___update_asm_0_remove](lib/solady/src/utils/RedBlackTreeLib.sol#L547) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L547


 - [ ] ID-256
Parameter [RedBlackTreeLib._update.asm_0.insert().cursor___update_asm_0_insert](lib/solady/src/utils/RedBlackTreeLib.sol#L394) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L394


 - [ ] ID-257
Parameter [RedBlackTreeLib._update.asm_0.rotate().nodes___update_asm_0_rotate](lib/solady/src/utils/RedBlackTreeLib.sol#L362) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L362


 - [ ] ID-258
Parameter [RedBlackTreeLib._update.asm_0.setKey().packed___update_asm_0_setKey](lib/solady/src/utils/RedBlackTreeLib.sol#L358) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L358


 - [ ] ID-259
Constant [OwnableUpgradeable.OwnableStorageLocation](lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L28) is not in UPPER_CASE_WITH_UNDERSCORES

lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L28


 - [ ] ID-260
Function [Ownable2StepUpgradeable.__Ownable2Step_init_unchained()](lib/openzeppelin-contracts-upgradeable/contracts/access/Ownable2StepUpgradeable.sol#L46-L47) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/access/Ownable2StepUpgradeable.sol#L46-L47


 - [ ] ID-261
Parameter [RedBlackTreeLib._update.asm_0.getKey().packed___update_asm_0_getKey](lib/solady/src/utils/RedBlackTreeLib.sol#L354) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L354


 - [ ] ID-262
Parameter [AccountManager.initialize(address)._owner](contracts/account-manager/AccountManager.sol#L118) is not in mixedCase

contracts/account-manager/AccountManager.sol#L118


 - [ ] ID-263
Parameter [RedBlackTreeLib._update.asm_0.replaceParent().parent___update_asm_0_replaceParent](lib/solady/src/utils/RedBlackTreeLib.sol#L536) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L536


 - [ ] ID-264
Parameter [RedBlackTreeLib._update.asm_0.insert().key___update_asm_0_insert](lib/solady/src/utils/RedBlackTreeLib.sol#L394) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L394


 - [ ] ID-265
Function [ERC20.DOMAIN_SEPARATOR()](lib/solady/src/tokens/ERC20.sol#L472-L487) is not in mixedCase

lib/solady/src/tokens/ERC20.sol#L472-L487


 - [ ] ID-266
Function [IUniswapV2Pair.PERMIT_TYPEHASH()](contracts/launchpad/interfaces/IUniswapV2Pair.sol#L19) is not in mixedCase

contracts/launchpad/interfaces/IUniswapV2Pair.sol#L19


 - [ ] ID-267
Parameter [RedBlackTreeLib.values.asm_0.visit().current__values_asm_0_visit](lib/solady/src/utils/RedBlackTreeLib.sol#L114) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L114


 - [ ] ID-268
Struct [CLOB.__MatchData__](contracts/clob/CLOB.sol#L732-L736) is not in CapWords

contracts/clob/CLOB.sol#L732-L736


 - [ ] ID-269
Function [IUniswapV2Pair.MINIMUM_LIQUIDITY()](contracts/launchpad/interfaces/IUniswapV2Pair.sol#L37) is not in mixedCase

contracts/launchpad/interfaces/IUniswapV2Pair.sol#L37


 - [ ] ID-270
Parameter [RedBlackTreeLib._update.asm_0.setKey().bitpos___update_asm_0_setKey](lib/solady/src/utils/RedBlackTreeLib.sol#L358) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L358


 - [ ] ID-271
Function [OwnableUpgradeable.__Ownable_init(address)](lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L51-L53) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L51-L53


 - [ ] ID-272
Parameter [RedBlackTreeLib._update.asm_0.rotate().R__update_asm_0_rotate](lib/solady/src/utils/RedBlackTreeLib.sol#L362) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L362


 - [ ] ID-273
Parameter [RedBlackTreeLib._update.asm_0.getKey().bitpos___update_asm_0_getKey](lib/solady/src/utils/RedBlackTreeLib.sol#L354) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L354


 - [ ] ID-274
Parameter [RedBlackTreeLib._update.asm_0.remove().key___update_asm_0_remove](lib/solady/src/utils/RedBlackTreeLib.sol#L547) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L547


 - [ ] ID-275
Parameter [RedBlackTreeLib._update.asm_0.replaceParent().a___update_asm_0_replaceParent](lib/solady/src/utils/RedBlackTreeLib.sol#L536) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L536


 - [ ] ID-276
Function [IEIP712.DOMAIN_SEPARATOR()](lib/permit2/src/interfaces/IEIP712.sol#L5) is not in mixedCase

lib/permit2/src/interfaces/IEIP712.sol#L5


 - [ ] ID-277
Function [IUniswapV2Pair.DOMAIN_SEPARATOR()](contracts/launchpad/interfaces/IUniswapV2Pair.sol#L18) is not in mixedCase

contracts/launchpad/interfaces/IUniswapV2Pair.sol#L18


 - [ ] ID-278
Parameter [RedBlackTreeLib._update.asm_0.rotate().key___update_asm_0_rotate](lib/solady/src/utils/RedBlackTreeLib.sol#L362) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L362


 - [ ] ID-279
Function [OwnableUpgradeable.__Ownable_init_unchained(address)](lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L55-L60) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol#L55-L60


 - [ ] ID-280
Parameter [RedBlackTreeLib._update.asm_0.insert().nodes___update_asm_0_insert](lib/solady/src/utils/RedBlackTreeLib.sol#L394) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L394


 - [ ] ID-281
Function [ContextUpgradeable.__Context_init_unchained()](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L21-L22) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L21-L22


 - [ ] ID-282
Parameter [RedBlackTreeLib._update.asm_0.setKey().key___update_asm_0_setKey](lib/solady/src/utils/RedBlackTreeLib.sol#L358) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L358


 - [ ] ID-283
Parameter [RedBlackTreeLib._update.asm_0.replaceParent().nodes___update_asm_0_replaceParent](lib/solady/src/utils/RedBlackTreeLib.sol#L536) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L536


 - [ ] ID-284
Parameter [RedBlackTreeLib._update.asm_0.removeFixup().key___update_asm_0_removeFixup](lib/solady/src/utils/RedBlackTreeLib.sol#L481) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L481


 - [ ] ID-285
Parameter [Distributor.initialize(address)._launchpad](contracts/launchpad/Distributor.sol#L39) is not in mixedCase

contracts/launchpad/Distributor.sol#L39


 - [ ] ID-286
Parameter [RedBlackTreeLib._update.asm_0.insert().x___update_asm_0_insert](lib/solady/src/utils/RedBlackTreeLib.sol#L394) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L394


 - [ ] ID-287
Function [Ownable2StepUpgradeable.__Ownable2Step_init()](lib/openzeppelin-contracts-upgradeable/contracts/access/Ownable2StepUpgradeable.sol#L43-L44) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/access/Ownable2StepUpgradeable.sol#L43-L44


 - [ ] ID-288
Parameter [CLOBManager.initialize(address)._owner](contracts/clob/CLOBManager.sol#L133) is not in mixedCase

contracts/clob/CLOBManager.sol#L133


 - [ ] ID-289
Struct [GTERouter.__RouteMetadata__](contracts/router/GTERouter.sol#L226-L231) is not in CapWords

contracts/router/GTERouter.sol#L226-L231


 - [ ] ID-290
Function [ContextUpgradeable.__Context_init()](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L18-L19) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L18-L19


 - [ ] ID-291
Parameter [RedBlackTreeLib._update.asm_0.rotate().L__update_asm_0_rotate](lib/solady/src/utils/RedBlackTreeLib.sol#L362) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L362


 - [ ] ID-292
Parameter [RedBlackTreeLib._update.asm_0.removeFixup().nodes___update_asm_0_removeFixup](lib/solady/src/utils/RedBlackTreeLib.sol#L481) is not in mixedCase

lib/solady/src/utils/RedBlackTreeLib.sol#L481


## too-many-digits
Impact: Informational
Confidence: Medium
 - [ ] ID-293
[FixedPointMathLib.cbrtWad(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L824-L848) uses literals with too many digits:
	- [p_cbrtWad_asm_0 = p_cbrtWad_asm_0 * 100000000000000000](lib/solady/src/utils/FixedPointMathLib.sol#L836)

lib/solady/src/utils/FixedPointMathLib.sol#L824-L848


 - [ ] ID-294
[SafeTransferLib.trySafeTransferFrom(address,address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L221-L239) uses literals with too many digits:
	- [mstore(uint256,uint256)(0x0c,0x23b872dd000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L231)

lib/solady/src/utils/SafeTransferLib.sol#L221-L239


 - [ ] ID-295
[FixedPointMathLib.log10(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L892-L913) uses literals with too many digits:
	- [x = x / 10000000000](lib/solady/src/utils/FixedPointMathLib.sol#L904)

lib/solady/src/utils/FixedPointMathLib.sol#L892-L913


 - [ ] ID-296
[FixedPointMathLib.sci(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L950-L985) uses literals with too many digits:
	- [mantissa = mantissa / 1000000000000000000000000000000000](lib/solady/src/utils/FixedPointMathLib.sol#L956)

lib/solady/src/utils/FixedPointMathLib.sol#L950-L985


 - [ ] ID-297
[SafeTransferLib.permit2TransferFrom(address,address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L431-L456) uses literals with too many digits:
	- [mstore(uint256,uint256)(m_permit2TransferFrom_asm_0,0x36c78516000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L442)

lib/solady/src/utils/SafeTransferLib.sol#L431-L456


 - [ ] ID-298
[FixedPointMathLib.log10(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L892-L913) uses literals with too many digits:
	- [! x < 100000](lib/solady/src/utils/FixedPointMathLib.sol#L907-L910)

lib/solady/src/utils/FixedPointMathLib.sol#L892-L913


 - [ ] ID-299
[FixedPointMathLib.log10(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L892-L913) uses literals with too many digits:
	- [! x < 10000000000](lib/solady/src/utils/FixedPointMathLib.sol#L903-L906)

lib/solady/src/utils/FixedPointMathLib.sol#L892-L913


 - [ ] ID-300
[FixedPointMathLib.sci(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L950-L985) uses literals with too many digits:
	- [mantissa = mantissa / 1000000000000](lib/solady/src/utils/FixedPointMathLib.sol#L964)

lib/solady/src/utils/FixedPointMathLib.sol#L950-L985


 - [ ] ID-301
[SafeTransferLib.safeTransferFrom(address,address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L198-L216) uses literals with too many digits:
	- [mstore(uint256,uint256)(0x0c,0x23b872dd000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L205)

lib/solady/src/utils/SafeTransferLib.sol#L198-L216


 - [ ] ID-302
[FixedPointMathLib.log10(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L892-L913) uses literals with too many digits:
	- [x = x / 100000000000000000000000000000000000000](lib/solady/src/utils/FixedPointMathLib.sol#L896)

lib/solady/src/utils/FixedPointMathLib.sol#L892-L913


 - [ ] ID-303
[SafeTransferLib.permit2(address,address,address,uint256,uint256,uint8,bytes32,bytes32)](lib/solady/src/utils/SafeTransferLib.sol#L461-L512) uses literals with too many digits:
	- [mstore(uint256,uint256)(0x00,0x7ecebe00000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L491)

lib/solady/src/utils/SafeTransferLib.sol#L461-L512


 - [ ] ID-304
[SafeTransferLib.safeTransferAllFrom(address,address,address)](lib/solady/src/utils/SafeTransferLib.sol#L245-L278) uses literals with too many digits:
	- [mstore(uint256,uint256)(0x0c,0x70a08231000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L254)

lib/solady/src/utils/SafeTransferLib.sol#L245-L278


 - [ ] ID-305
[SafeTransferLib.safeApprove(address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L334-L349) uses literals with too many digits:
	- [mstore(uint256,uint256)(0x00,0x095ea7b3000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L339)

lib/solady/src/utils/SafeTransferLib.sol#L334-L349


 - [ ] ID-306
[FixedPointMathLib.log10(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L892-L913) uses literals with too many digits:
	- [! x < 100000000000000000000](lib/solady/src/utils/FixedPointMathLib.sol#L899-L902)

lib/solady/src/utils/FixedPointMathLib.sol#L892-L913


 - [ ] ID-307
[FixedPointMathLib.sci(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L950-L985) uses literals with too many digits:
	- [! mantissa % 1000000000000000000000000000000000](lib/solady/src/utils/FixedPointMathLib.sol#L955-L958)

lib/solady/src/utils/FixedPointMathLib.sol#L950-L985


 - [ ] ID-308
[FixedPointMathLib.lambertW0Wad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L353-L434) uses literals with too many digits:
	- [- 0x4000000000000 <= w](lib/solady/src/utils/FixedPointMathLib.sol#L361)

lib/solady/src/utils/FixedPointMathLib.sol#L353-L434


 - [ ] ID-309
[FixedPointMathLib.log10(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L892-L913) uses literals with too many digits:
	- [x = x / 100000](lib/solady/src/utils/FixedPointMathLib.sol#L908)

lib/solady/src/utils/FixedPointMathLib.sol#L892-L913


 - [ ] ID-310
[FixedPointMathLib.sci(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L950-L985) uses literals with too many digits:
	- [! mantissa % 1000000000000](lib/solady/src/utils/FixedPointMathLib.sol#L963-L966)

lib/solady/src/utils/FixedPointMathLib.sol#L950-L985


 - [ ] ID-311
[FixedPointMathLib.lambertW0Wad(int256)](lib/solady/src/utils/FixedPointMathLib.sol#L353-L434) uses literals with too many digits:
	- [l_lambertW0Wad_asm_0 = l_lambertW0Wad_asm_0 | byte(uint256,uint256)(0x1f & 0x8421084210842108cc6318c6db6d54be >> v_lambertW0Wad_asm_0 >> l_lambertW0Wad_asm_0,0x0706060506020504060203020504030106050205030304010505030400000000) + 49](lib/solady/src/utils/FixedPointMathLib.sol#L372-L373)

lib/solady/src/utils/FixedPointMathLib.sol#L353-L434


 - [ ] ID-312
[SafeTransferLib.safeApproveWithRetry(address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L355-L382) uses literals with too many digits:
	- [mstore(uint256,uint256)(0x00,0x095ea7b3000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L360)

lib/solady/src/utils/SafeTransferLib.sol#L355-L382


 - [ ] ID-313
[FixedPointMathLib.log10(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L892-L913) uses literals with too many digits:
	- [x = x / 100000000000000000000](lib/solady/src/utils/FixedPointMathLib.sol#L900)

lib/solady/src/utils/FixedPointMathLib.sol#L892-L913


 - [ ] ID-314
[FixedPointMathLib.sci(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L950-L985) uses literals with too many digits:
	- [mantissa = mantissa / 1000000](lib/solady/src/utils/FixedPointMathLib.sol#L968)

lib/solady/src/utils/FixedPointMathLib.sol#L950-L985


 - [ ] ID-315
[FixedPointMathLib.log2(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L866-L878) uses literals with too many digits:
	- [r = r | byte(uint256,uint256)(0x1f & 0x8421084210842108cc6318c6db6d54be >> x >> r,0x0706060506020504060203020504030106050205030304010505030400000000)](lib/solady/src/utils/FixedPointMathLib.sol#L875-L876)

lib/solady/src/utils/FixedPointMathLib.sol#L866-L878


 - [ ] ID-316
[FixedPointMathLib.sci(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L950-L985) uses literals with too many digits:
	- [! mantissa % 1000000](lib/solady/src/utils/FixedPointMathLib.sol#L967-L970)

lib/solady/src/utils/FixedPointMathLib.sol#L950-L985


 - [ ] ID-317
[FixedPointMathLib.log10(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L892-L913) uses literals with too many digits:
	- [! x < 100000000000000000000000000000000000000](lib/solady/src/utils/FixedPointMathLib.sol#L895-L898)

lib/solady/src/utils/FixedPointMathLib.sol#L892-L913


 - [ ] ID-318
[SafeTransferLib.safeTransferAll(address,address)](lib/solady/src/utils/SafeTransferLib.sol#L302-L330) uses literals with too many digits:
	- [mstore(uint256,uint256)(0x00,0xa9059cbb000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L319)

lib/solady/src/utils/SafeTransferLib.sol#L302-L330


 - [ ] ID-319
[SafeTransferLib.safeApproveWithRetry(address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L355-L382) uses literals with too many digits:
	- [mstore(uint256,uint256)(0x00,0x095ea7b3000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L366)

lib/solady/src/utils/SafeTransferLib.sol#L355-L382


 - [ ] ID-320
[SafeTransferLib.safeTransfer(address,address,uint256)](lib/solady/src/utils/SafeTransferLib.sol#L282-L298) uses literals with too many digits:
	- [mstore(uint256,uint256)(0x00,0xa9059cbb000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L287)

lib/solady/src/utils/SafeTransferLib.sol#L282-L298


 - [ ] ID-321
[SafeTransferLib.slitherConstructorConstantVariables()](lib/solady/src/utils/SafeTransferLib.sol#L11-L566) uses literals with too many digits:
	- [GAS_STIPEND_NO_GRIEF = 100000](lib/solady/src/utils/SafeTransferLib.sol#L46)

lib/solady/src/utils/SafeTransferLib.sol#L11-L566


 - [ ] ID-322
[FixedPointMathLib.sci(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L950-L985) uses literals with too many digits:
	- [mantissa = mantissa / 10000000000000000000](lib/solady/src/utils/FixedPointMathLib.sol#L960)

lib/solady/src/utils/FixedPointMathLib.sol#L950-L985


 - [ ] ID-323
[FixedPointMathLib.cbrtWad(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L824-L848) uses literals with too many digits:
	- [p_cbrtWad_asm_0 = p_cbrtWad_asm_0 * 100000000](lib/solady/src/utils/FixedPointMathLib.sol#L839)

lib/solady/src/utils/FixedPointMathLib.sol#L824-L848


 - [ ] ID-324
[SafeTransferLib.permit2(address,address,address,uint256,uint256,uint8,bytes32,bytes32)](lib/solady/src/utils/SafeTransferLib.sol#L461-L512) uses literals with too many digits:
	- [mstore(uint256,uint256)(m_permit2_asm_0,0xd505accf000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L502)

lib/solady/src/utils/SafeTransferLib.sol#L461-L512


 - [ ] ID-325
[SafeTransferLib.permit2(address,address,address,uint256,uint256,uint8,bytes32,bytes32)](lib/solady/src/utils/SafeTransferLib.sol#L461-L512) uses literals with too many digits:
	- [mstore(uint256,uint256)(m_permit2_asm_0,0x8fcbaf0c000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L493)

lib/solady/src/utils/SafeTransferLib.sol#L461-L512


 - [ ] ID-326
[FixedPointMathLib.sci(uint256)](lib/solady/src/utils/FixedPointMathLib.sol#L950-L985) uses literals with too many digits:
	- [! mantissa % 10000000000000000000](lib/solady/src/utils/FixedPointMathLib.sol#L959-L962)

lib/solady/src/utils/FixedPointMathLib.sol#L950-L985


 - [ ] ID-327
[SafeTransferLib.balanceOf(address,address)](lib/solady/src/utils/SafeTransferLib.sol#L386-L400) uses literals with too many digits:
	- [mstore(uint256,uint256)(0x00,0x70a08231000000000000000000000000)](lib/solady/src/utils/SafeTransferLib.sol#L390)

lib/solady/src/utils/SafeTransferLib.sol#L386-L400


## unused-state
Impact: Informational
Confidence: High
 - [ ] ID-328
[OwnableRoles._ROLE_157](lib/solady/src/auth/OwnableRoles.sol#L436) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L436


 - [ ] ID-329
[OwnableRoles._ROLE_231](lib/solady/src/auth/OwnableRoles.sol#L510) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L510


 - [ ] ID-330
[OwnableRoles._ROLE_158](lib/solady/src/auth/OwnableRoles.sol#L437) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L437


 - [ ] ID-331
[OwnableRoles._ROLE_65](lib/solady/src/auth/OwnableRoles.sol#L344) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L344


 - [ ] ID-332
[OwnableRoles._ROLE_56](lib/solady/src/auth/OwnableRoles.sol#L335) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L335


 - [ ] ID-333
[OwnableRoles._ROLE_73](lib/solady/src/auth/OwnableRoles.sol#L352) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L352


 - [ ] ID-334
[OwnableRoles._ROLE_153](lib/solady/src/auth/OwnableRoles.sol#L432) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L432


 - [ ] ID-335
[OwnableRoles._ROLE_172](lib/solady/src/auth/OwnableRoles.sol#L451) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L451


 - [ ] ID-336
[OwnableRoles._ROLE_34](lib/solady/src/auth/OwnableRoles.sol#L313) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L313


 - [ ] ID-337
[OwnableRoles._ROLE_163](lib/solady/src/auth/OwnableRoles.sol#L442) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L442


 - [ ] ID-338
[OwnableRoles._ROLE_52](lib/solady/src/auth/OwnableRoles.sol#L331) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L331


 - [ ] ID-339
[OwnableRoles._ROLE_101](lib/solady/src/auth/OwnableRoles.sol#L380) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L380


 - [ ] ID-340
[OwnableRoles._ROLE_37](lib/solady/src/auth/OwnableRoles.sol#L316) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L316


 - [ ] ID-341
[OwnableRoles._ROLE_122](lib/solady/src/auth/OwnableRoles.sol#L401) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L401


 - [ ] ID-342
[OwnableRoles._ROLE_57](lib/solady/src/auth/OwnableRoles.sol#L336) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L336


 - [ ] ID-343
[OwnableRoles._ROLE_22](lib/solady/src/auth/OwnableRoles.sol#L301) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L301


 - [ ] ID-344
[OwnableRoles._ROLE_108](lib/solady/src/auth/OwnableRoles.sol#L387) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L387


 - [ ] ID-345
[OwnableRoles._ROLE_129](lib/solady/src/auth/OwnableRoles.sol#L408) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L408


 - [ ] ID-346
[OwnableRoles._ROLE_77](lib/solady/src/auth/OwnableRoles.sol#L356) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L356


 - [ ] ID-347
[OwnableRoles._ROLE_14](lib/solady/src/auth/OwnableRoles.sol#L293) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L293


 - [ ] ID-348
[OwnableRoles._ROLE_223](lib/solady/src/auth/OwnableRoles.sol#L502) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L502


 - [ ] ID-349
[OwnableRoles._ROLE_114](lib/solady/src/auth/OwnableRoles.sol#L393) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L393


 - [ ] ID-350
[OwnableRoles._ROLE_217](lib/solady/src/auth/OwnableRoles.sol#L496) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L496


 - [ ] ID-351
[OwnableRoles._ROLE_91](lib/solady/src/auth/OwnableRoles.sol#L370) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L370


 - [ ] ID-352
[OwnableRoles._ROLE_185](lib/solady/src/auth/OwnableRoles.sol#L464) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L464


 - [ ] ID-353
[OwnableRoles._ROLE_210](lib/solady/src/auth/OwnableRoles.sol#L489) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L489


 - [ ] ID-354
[OwnableRoles._ROLE_88](lib/solady/src/auth/OwnableRoles.sol#L367) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L367


 - [ ] ID-355
[OwnableRoles._ROLE_181](lib/solady/src/auth/OwnableRoles.sol#L460) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L460


 - [ ] ID-356
[OwnableRoles._ROLE_81](lib/solady/src/auth/OwnableRoles.sol#L360) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L360


 - [ ] ID-357
[OwnableRoles._ROLE_84](lib/solady/src/auth/OwnableRoles.sol#L363) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L363


 - [ ] ID-358
[OwnableRoles._ROLE_165](lib/solady/src/auth/OwnableRoles.sol#L444) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L444


 - [ ] ID-359
[OwnableRoles._ROLE_179](lib/solady/src/auth/OwnableRoles.sol#L458) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L458


 - [ ] ID-360
[OwnableRoles._ROLE_124](lib/solady/src/auth/OwnableRoles.sol#L403) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L403


 - [ ] ID-361
[OwnableRoles._ROLE_161](lib/solady/src/auth/OwnableRoles.sol#L440) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L440


 - [ ] ID-362
[OwnableRoles._ROLE_23](lib/solady/src/auth/OwnableRoles.sol#L302) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L302


 - [ ] ID-363
[OwnableRoles._ROLE_216](lib/solady/src/auth/OwnableRoles.sol#L495) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L495


 - [ ] ID-364
[OwnableRoles._ROLE_9](lib/solady/src/auth/OwnableRoles.sol#L288) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L288


 - [ ] ID-365
[OwnableRoles._ROLE_162](lib/solady/src/auth/OwnableRoles.sol#L441) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L441


 - [ ] ID-366
[OwnableRoles._ROLE_59](lib/solady/src/auth/OwnableRoles.sol#L338) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L338


 - [ ] ID-367
[OwnableRoles._ROLE_251](lib/solady/src/auth/OwnableRoles.sol#L530) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L530


 - [ ] ID-368
[OwnableRoles._ROLE_187](lib/solady/src/auth/OwnableRoles.sol#L466) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L466


 - [ ] ID-369
[OwnableRoles._ROLE_129](lib/solady/src/auth/OwnableRoles.sol#L408) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L408


 - [ ] ID-370
[OwnableRoles._ROLE_20](lib/solady/src/auth/OwnableRoles.sol#L299) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L299


 - [ ] ID-371
[OwnableRoles._ROLE_101](lib/solady/src/auth/OwnableRoles.sol#L380) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L380


 - [ ] ID-372
[OwnableRoles._ROLE_254](lib/solady/src/auth/OwnableRoles.sol#L533) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L533


 - [ ] ID-373
[OwnableRoles._ROLE_93](lib/solady/src/auth/OwnableRoles.sol#L372) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L372


 - [ ] ID-374
[OwnableRoles._ROLE_85](lib/solady/src/auth/OwnableRoles.sol#L364) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L364


 - [ ] ID-375
[OwnableRoles._ROLE_79](lib/solady/src/auth/OwnableRoles.sol#L358) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L358


 - [ ] ID-376
[OwnableRoles._ROLE_21](lib/solady/src/auth/OwnableRoles.sol#L300) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L300


 - [ ] ID-377
[OwnableRoles._ROLE_164](lib/solady/src/auth/OwnableRoles.sol#L443) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L443


 - [ ] ID-378
[OwnableRoles._ROLE_191](lib/solady/src/auth/OwnableRoles.sol#L470) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L470


 - [ ] ID-379
[OwnableRoles._ROLE_186](lib/solady/src/auth/OwnableRoles.sol#L465) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L465


 - [ ] ID-380
[OwnableRoles._ROLE_82](lib/solady/src/auth/OwnableRoles.sol#L361) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L361


 - [ ] ID-381
[OwnableRoles._ROLE_44](lib/solady/src/auth/OwnableRoles.sol#L323) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L323


 - [ ] ID-382
[OwnableRoles._ROLE_99](lib/solady/src/auth/OwnableRoles.sol#L378) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L378


 - [ ] ID-383
[OwnableRoles._ROLE_118](lib/solady/src/auth/OwnableRoles.sol#L397) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L397


 - [ ] ID-384
[OwnableRoles._ROLE_60](lib/solady/src/auth/OwnableRoles.sol#L339) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L339


 - [ ] ID-385
[OwnableRoles._ROLE_226](lib/solady/src/auth/OwnableRoles.sol#L505) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L505


 - [ ] ID-386
[OwnableRoles._ROLE_28](lib/solady/src/auth/OwnableRoles.sol#L307) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L307


 - [ ] ID-387
[OwnableRoles._ROLE_123](lib/solady/src/auth/OwnableRoles.sol#L402) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L402


 - [ ] ID-388
[OwnableRoles._ROLE_81](lib/solady/src/auth/OwnableRoles.sol#L360) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L360


 - [ ] ID-389
[OwnableRoles._ROLE_173](lib/solady/src/auth/OwnableRoles.sol#L452) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L452


 - [ ] ID-390
[OwnableRoles._ROLE_227](lib/solady/src/auth/OwnableRoles.sol#L506) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L506


 - [ ] ID-391
[OwnableRoles._ROLE_248](lib/solady/src/auth/OwnableRoles.sol#L527) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L527


 - [ ] ID-392
[OwnableRoles._ROLE_154](lib/solady/src/auth/OwnableRoles.sol#L433) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L433


 - [ ] ID-393
[OwnableRoles._ROLE_241](lib/solady/src/auth/OwnableRoles.sol#L520) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L520


 - [ ] ID-394
[OwnableRoles._ROLE_252](lib/solady/src/auth/OwnableRoles.sol#L531) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L531


 - [ ] ID-395
[OwnableRoles._ROLE_55](lib/solady/src/auth/OwnableRoles.sol#L334) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L334


 - [ ] ID-396
[OwnableRoles._ROLE_134](lib/solady/src/auth/OwnableRoles.sol#L413) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L413


 - [ ] ID-397
[OwnableRoles._ROLE_142](lib/solady/src/auth/OwnableRoles.sol#L421) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L421


 - [ ] ID-398
[OwnableRoles._ROLE_103](lib/solady/src/auth/OwnableRoles.sol#L382) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L382


 - [ ] ID-399
[OwnableRoles._ROLE_54](lib/solady/src/auth/OwnableRoles.sol#L333) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L333


 - [ ] ID-400
[OwnableRoles._ROLE_115](lib/solady/src/auth/OwnableRoles.sol#L394) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L394


 - [ ] ID-401
[OwnableRoles._ROLE_173](lib/solady/src/auth/OwnableRoles.sol#L452) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L452


 - [ ] ID-402
[OwnableRoles._ROLE_2](lib/solady/src/auth/OwnableRoles.sol#L281) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L281


 - [ ] ID-403
[OwnableRoles._ROLE_36](lib/solady/src/auth/OwnableRoles.sol#L315) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L315


 - [ ] ID-404
[OwnableRoles._ROLE_155](lib/solady/src/auth/OwnableRoles.sol#L434) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L434


 - [ ] ID-405
[OwnableRoles._ROLE_46](lib/solady/src/auth/OwnableRoles.sol#L325) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L325


 - [ ] ID-406
[OwnableRoles._ROLE_155](lib/solady/src/auth/OwnableRoles.sol#L434) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L434


 - [ ] ID-407
[OwnableRoles._ROLE_116](lib/solady/src/auth/OwnableRoles.sol#L395) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L395


 - [ ] ID-408
[OwnableRoles._ROLE_160](lib/solady/src/auth/OwnableRoles.sol#L439) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L439


 - [ ] ID-409
[OwnableRoles._ROLE_142](lib/solady/src/auth/OwnableRoles.sol#L421) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L421


 - [ ] ID-410
[OwnableRoles._ROLE_196](lib/solady/src/auth/OwnableRoles.sol#L475) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L475


 - [ ] ID-411
[OwnableRoles._ROLE_185](lib/solady/src/auth/OwnableRoles.sol#L464) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L464


 - [ ] ID-412
[OwnableRoles._ROLE_3](lib/solady/src/auth/OwnableRoles.sol#L282) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L282


 - [ ] ID-413
[OwnableRoles._ROLE_237](lib/solady/src/auth/OwnableRoles.sol#L516) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L516


 - [ ] ID-414
[OwnableRoles._ROLE_95](lib/solady/src/auth/OwnableRoles.sol#L374) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L374


 - [ ] ID-415
[OwnableRoles._ROLE_131](lib/solady/src/auth/OwnableRoles.sol#L410) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L410


 - [ ] ID-416
[OwnableRoles._ROLE_1](lib/solady/src/auth/OwnableRoles.sol#L280) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L280


 - [ ] ID-417
[OwnableRoles._ROLE_141](lib/solady/src/auth/OwnableRoles.sol#L420) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L420


 - [ ] ID-418
[OwnableRoles._ROLE_169](lib/solady/src/auth/OwnableRoles.sol#L448) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L448


 - [ ] ID-419
[OwnableRoles._ROLE_124](lib/solady/src/auth/OwnableRoles.sol#L403) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L403


 - [ ] ID-420
[OwnableRoles._ROLE_166](lib/solady/src/auth/OwnableRoles.sol#L445) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L445


 - [ ] ID-421
[OwnableRoles._ROLE_33](lib/solady/src/auth/OwnableRoles.sol#L312) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L312


 - [ ] ID-422
[OwnableRoles._ROLE_186](lib/solady/src/auth/OwnableRoles.sol#L465) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L465


 - [ ] ID-423
[OwnableRoles._ROLE_86](lib/solady/src/auth/OwnableRoles.sol#L365) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L365


 - [ ] ID-424
[OwnableRoles._ROLE_214](lib/solady/src/auth/OwnableRoles.sol#L493) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L493


 - [ ] ID-425
[OwnableRoles._ROLE_243](lib/solady/src/auth/OwnableRoles.sol#L522) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L522


 - [ ] ID-426
[OwnableRoles._ROLE_105](lib/solady/src/auth/OwnableRoles.sol#L384) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L384


 - [ ] ID-427
[OwnableRoles._ROLE_4](lib/solady/src/auth/OwnableRoles.sol#L283) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L283


 - [ ] ID-428
[OwnableRoles._ROLE_130](lib/solady/src/auth/OwnableRoles.sol#L409) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L409


 - [ ] ID-429
[OwnableRoles._ROLE_69](lib/solady/src/auth/OwnableRoles.sol#L348) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L348


 - [ ] ID-430
[OwnableRoles._ROLE_158](lib/solady/src/auth/OwnableRoles.sol#L437) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L437


 - [ ] ID-431
[OwnableRoles._ROLE_25](lib/solady/src/auth/OwnableRoles.sol#L304) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L304


 - [ ] ID-432
[OwnableRoles._ROLE_14](lib/solady/src/auth/OwnableRoles.sol#L293) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L293


 - [ ] ID-433
[OwnableRoles._ROLE_120](lib/solady/src/auth/OwnableRoles.sol#L399) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L399


 - [ ] ID-434
[OwnableRoles._ROLE_231](lib/solady/src/auth/OwnableRoles.sol#L510) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L510


 - [ ] ID-435
[OwnableRoles._ROLE_50](lib/solady/src/auth/OwnableRoles.sol#L329) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L329


 - [ ] ID-436
[OwnableRoles._ROLE_236](lib/solady/src/auth/OwnableRoles.sol#L515) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L515


 - [ ] ID-437
[OwnableRoles._ROLE_94](lib/solady/src/auth/OwnableRoles.sol#L373) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L373


 - [ ] ID-438
[OwnableRoles._ROLE_70](lib/solady/src/auth/OwnableRoles.sol#L349) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L349


 - [ ] ID-439
[OwnableRoles._ROLE_69](lib/solady/src/auth/OwnableRoles.sol#L348) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L348


 - [ ] ID-440
[OwnableRoles._ROLE_34](lib/solady/src/auth/OwnableRoles.sol#L313) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L313


 - [ ] ID-441
[OwnableRoles._ROLE_32](lib/solady/src/auth/OwnableRoles.sol#L311) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L311


 - [ ] ID-442
[OwnableRoles._ROLE_152](lib/solady/src/auth/OwnableRoles.sol#L431) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L431


 - [ ] ID-443
[OwnableRoles._ROLE_136](lib/solady/src/auth/OwnableRoles.sol#L415) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L415


 - [ ] ID-444
[OwnableRoles._ROLE_126](lib/solady/src/auth/OwnableRoles.sol#L405) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L405


 - [ ] ID-445
[OwnableRoles._ROLE_189](lib/solady/src/auth/OwnableRoles.sol#L468) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L468


 - [ ] ID-446
[OwnableRoles._ROLE_206](lib/solady/src/auth/OwnableRoles.sol#L485) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L485


 - [ ] ID-447
[OwnableRoles._ROLE_182](lib/solady/src/auth/OwnableRoles.sol#L461) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L461


 - [ ] ID-448
[OwnableRoles._ROLE_53](lib/solady/src/auth/OwnableRoles.sol#L332) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L332


 - [ ] ID-449
[OwnableRoles._ROLE_39](lib/solady/src/auth/OwnableRoles.sol#L318) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L318


 - [ ] ID-450
[OwnableRoles._ROLE_197](lib/solady/src/auth/OwnableRoles.sol#L476) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L476


 - [ ] ID-451
[OwnableRoles._ROLE_127](lib/solady/src/auth/OwnableRoles.sol#L406) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L406


 - [ ] ID-452
[OwnableRoles._ROLE_16](lib/solady/src/auth/OwnableRoles.sol#L295) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L295


 - [ ] ID-453
[OwnableRoles._ROLE_216](lib/solady/src/auth/OwnableRoles.sol#L495) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L495


 - [ ] ID-454
[OwnableRoles._ROLE_234](lib/solady/src/auth/OwnableRoles.sol#L513) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L513


 - [ ] ID-455
[OwnableRoles._ROLE_48](lib/solady/src/auth/OwnableRoles.sol#L327) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L327


 - [ ] ID-456
[OwnableRoles._ROLE_71](lib/solady/src/auth/OwnableRoles.sol#L350) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L350


 - [ ] ID-457
[OwnableRoles._ROLE_171](lib/solady/src/auth/OwnableRoles.sol#L450) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L450


 - [ ] ID-458
[OwnableRoles._ROLE_61](lib/solady/src/auth/OwnableRoles.sol#L340) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L340


 - [ ] ID-459
[OwnableRoles._ROLE_198](lib/solady/src/auth/OwnableRoles.sol#L477) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L477


 - [ ] ID-460
[OwnableRoles._ROLE_194](lib/solady/src/auth/OwnableRoles.sol#L473) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L473


 - [ ] ID-461
[OwnableRoles._ROLE_63](lib/solady/src/auth/OwnableRoles.sol#L342) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L342


 - [ ] ID-462
[OwnableRoles._ROLE_97](lib/solady/src/auth/OwnableRoles.sol#L376) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L376


 - [ ] ID-463
[OwnableRoles._ROLE_53](lib/solady/src/auth/OwnableRoles.sol#L332) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L332


 - [ ] ID-464
[OwnableRoles._ROLE_237](lib/solady/src/auth/OwnableRoles.sol#L516) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L516


 - [ ] ID-465
[OwnableRoles._ROLE_152](lib/solady/src/auth/OwnableRoles.sol#L431) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L431


 - [ ] ID-466
[OwnableRoles._ROLE_130](lib/solady/src/auth/OwnableRoles.sol#L409) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L409


 - [ ] ID-467
[OwnableRoles._ROLE_189](lib/solady/src/auth/OwnableRoles.sol#L468) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L468


 - [ ] ID-468
[OwnableRoles._ROLE_120](lib/solady/src/auth/OwnableRoles.sol#L399) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L399


 - [ ] ID-469
[OwnableRoles._ROLE_187](lib/solady/src/auth/OwnableRoles.sol#L466) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L466


 - [ ] ID-470
[OwnableRoles._ROLE_100](lib/solady/src/auth/OwnableRoles.sol#L379) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L379


 - [ ] ID-471
[OwnableRoles._ROLE_66](lib/solady/src/auth/OwnableRoles.sol#L345) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L345


 - [ ] ID-472
[OwnableRoles._ROLE_32](lib/solady/src/auth/OwnableRoles.sol#L311) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L311


 - [ ] ID-473
[OwnableRoles._ROLE_58](lib/solady/src/auth/OwnableRoles.sol#L337) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L337


 - [ ] ID-474
[OwnableRoles._ROLE_212](lib/solady/src/auth/OwnableRoles.sol#L491) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L491


 - [ ] ID-475
[OwnableRoles._ROLE_248](lib/solady/src/auth/OwnableRoles.sol#L527) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L527


 - [ ] ID-476
[OwnableRoles._ROLE_26](lib/solady/src/auth/OwnableRoles.sol#L305) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L305


 - [ ] ID-477
[OwnableRoles._ROLE_117](lib/solady/src/auth/OwnableRoles.sol#L396) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L396


 - [ ] ID-478
[OwnableRoles._ROLE_232](lib/solady/src/auth/OwnableRoles.sol#L511) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L511


 - [ ] ID-479
[OwnableRoles._ROLE_145](lib/solady/src/auth/OwnableRoles.sol#L424) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L424


 - [ ] ID-480
[OwnableRoles._ROLE_79](lib/solady/src/auth/OwnableRoles.sol#L358) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L358


 - [ ] ID-481
[OwnableRoles._ROLE_176](lib/solady/src/auth/OwnableRoles.sol#L455) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L455


 - [ ] ID-482
[OwnableRoles._ROLE_82](lib/solady/src/auth/OwnableRoles.sol#L361) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L361


 - [ ] ID-483
[OwnableRoles._ROLE_186](lib/solady/src/auth/OwnableRoles.sol#L465) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L465


 - [ ] ID-484
[OwnableRoles._ROLE_82](lib/solady/src/auth/OwnableRoles.sol#L361) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L361


 - [ ] ID-485
[OwnableRoles._ROLE_134](lib/solady/src/auth/OwnableRoles.sol#L413) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L413


 - [ ] ID-486
[OwnableRoles._ROLE_120](lib/solady/src/auth/OwnableRoles.sol#L399) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L399


 - [ ] ID-487
[OwnableRoles._ROLE_78](lib/solady/src/auth/OwnableRoles.sol#L357) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L357


 - [ ] ID-488
[OwnableRoles._ROLE_92](lib/solady/src/auth/OwnableRoles.sol#L371) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L371


 - [ ] ID-489
[OwnableRoles._ROLE_126](lib/solady/src/auth/OwnableRoles.sol#L405) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L405


 - [ ] ID-490
[OwnableRoles._ROLE_76](lib/solady/src/auth/OwnableRoles.sol#L355) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L355


 - [ ] ID-491
[OwnableRoles._ROLE_195](lib/solady/src/auth/OwnableRoles.sol#L474) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L474


 - [ ] ID-492
[OwnableRoles._ROLE_72](lib/solady/src/auth/OwnableRoles.sol#L351) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L351


 - [ ] ID-493
[OwnableRoles._ROLE_206](lib/solady/src/auth/OwnableRoles.sol#L485) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L485


 - [ ] ID-494
[OwnableRoles._ROLE_20](lib/solady/src/auth/OwnableRoles.sol#L299) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L299


 - [ ] ID-495
[OwnableRoles._ROLE_140](lib/solady/src/auth/OwnableRoles.sol#L419) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L419


 - [ ] ID-496
[OwnableRoles._ROLE_228](lib/solady/src/auth/OwnableRoles.sol#L507) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L507


 - [ ] ID-497
[OwnableRoles._ROLE_47](lib/solady/src/auth/OwnableRoles.sol#L326) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L326


 - [ ] ID-498
[OwnableRoles._ROLE_208](lib/solady/src/auth/OwnableRoles.sol#L487) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L487


 - [ ] ID-499
[OwnableRoles._ROLE_86](lib/solady/src/auth/OwnableRoles.sol#L365) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L365


 - [ ] ID-500
[OwnableRoles._ROLE_243](lib/solady/src/auth/OwnableRoles.sol#L522) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L522


 - [ ] ID-501
[OwnableRoles._ROLE_232](lib/solady/src/auth/OwnableRoles.sol#L511) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L511


 - [ ] ID-502
[OwnableRoles._ROLE_230](lib/solady/src/auth/OwnableRoles.sol#L509) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L509


 - [ ] ID-503
[OwnableRoles._ROLE_247](lib/solady/src/auth/OwnableRoles.sol#L526) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L526


 - [ ] ID-504
[OwnableRoles._ROLE_106](lib/solady/src/auth/OwnableRoles.sol#L385) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L385


 - [ ] ID-505
[OwnableRoles._ROLE_157](lib/solady/src/auth/OwnableRoles.sol#L436) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L436


 - [ ] ID-506
[OwnableRoles._ROLE_49](lib/solady/src/auth/OwnableRoles.sol#L328) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L328


 - [ ] ID-507
[OwnableRoles._ROLE_16](lib/solady/src/auth/OwnableRoles.sol#L295) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L295


 - [ ] ID-508
[OwnableRoles._ROLE_241](lib/solady/src/auth/OwnableRoles.sol#L520) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L520


 - [ ] ID-509
[OwnableRoles._ROLE_37](lib/solady/src/auth/OwnableRoles.sol#L316) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L316


 - [ ] ID-510
[OwnableRoles._ROLE_234](lib/solady/src/auth/OwnableRoles.sol#L513) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L513


 - [ ] ID-511
[OwnableRoles._ROLE_177](lib/solady/src/auth/OwnableRoles.sol#L456) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L456


 - [ ] ID-512
[OwnableRoles._ROLE_62](lib/solady/src/auth/OwnableRoles.sol#L341) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L341


 - [ ] ID-513
[OwnableRoles._ROLE_209](lib/solady/src/auth/OwnableRoles.sol#L488) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L488


 - [ ] ID-514
[OwnableRoles._ROLE_144](lib/solady/src/auth/OwnableRoles.sol#L423) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L423


 - [ ] ID-515
[OwnableRoles._ROLE_211](lib/solady/src/auth/OwnableRoles.sol#L490) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L490


 - [ ] ID-516
[OwnableRoles._ROLE_201](lib/solady/src/auth/OwnableRoles.sol#L480) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L480


 - [ ] ID-517
[OwnableRoles._ROLE_175](lib/solady/src/auth/OwnableRoles.sol#L454) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L454


 - [ ] ID-518
[OwnableRoles._ROLE_144](lib/solady/src/auth/OwnableRoles.sol#L423) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L423


 - [ ] ID-519
[OwnableRoles._ROLE_250](lib/solady/src/auth/OwnableRoles.sol#L529) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L529


 - [ ] ID-520
[OwnableRoles._ROLE_89](lib/solady/src/auth/OwnableRoles.sol#L368) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L368


 - [ ] ID-521
[OwnableRoles._ROLE_11](lib/solady/src/auth/OwnableRoles.sol#L290) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L290


 - [ ] ID-522
[OwnableRoles._ROLE_56](lib/solady/src/auth/OwnableRoles.sol#L335) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L335


 - [ ] ID-523
[OwnableRoles._ROLE_153](lib/solady/src/auth/OwnableRoles.sol#L432) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L432


 - [ ] ID-524
[OwnableRoles._ROLE_109](lib/solady/src/auth/OwnableRoles.sol#L388) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L388


 - [ ] ID-525
[OwnableRoles._ROLE_119](lib/solady/src/auth/OwnableRoles.sol#L398) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L398


 - [ ] ID-526
[OwnableRoles._ROLE_15](lib/solady/src/auth/OwnableRoles.sol#L294) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L294


 - [ ] ID-527
[OwnableRoles._ROLE_176](lib/solady/src/auth/OwnableRoles.sol#L455) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L455


 - [ ] ID-528
[OwnableRoles._ROLE_73](lib/solady/src/auth/OwnableRoles.sol#L352) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L352


 - [ ] ID-529
[OwnableRoles._ROLE_98](lib/solady/src/auth/OwnableRoles.sol#L377) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L377


 - [ ] ID-530
[OwnableRoles._ROLE_182](lib/solady/src/auth/OwnableRoles.sol#L461) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L461


 - [ ] ID-531
[OwnableRoles._ROLE_30](lib/solady/src/auth/OwnableRoles.sol#L309) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L309


 - [ ] ID-532
[OwnableRoles._ROLE_39](lib/solady/src/auth/OwnableRoles.sol#L318) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L318


 - [ ] ID-533
[OwnableRoles._ROLE_106](lib/solady/src/auth/OwnableRoles.sol#L385) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L385


 - [ ] ID-534
[OwnableRoles._ROLE_183](lib/solady/src/auth/OwnableRoles.sol#L462) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L462


 - [ ] ID-535
[OwnableRoles._ROLE_207](lib/solady/src/auth/OwnableRoles.sol#L486) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L486


 - [ ] ID-536
[OwnableRoles._ROLE_251](lib/solady/src/auth/OwnableRoles.sol#L530) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L530


 - [ ] ID-537
[OwnableRoles._ROLE_58](lib/solady/src/auth/OwnableRoles.sol#L337) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L337


 - [ ] ID-538
[OwnableRoles._ROLE_51](lib/solady/src/auth/OwnableRoles.sol#L330) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L330


 - [ ] ID-539
[OwnableRoles._ROLE_137](lib/solady/src/auth/OwnableRoles.sol#L416) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L416


 - [ ] ID-540
[OwnableRoles._ROLE_65](lib/solady/src/auth/OwnableRoles.sol#L344) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L344


 - [ ] ID-541
[OwnableRoles._ROLE_209](lib/solady/src/auth/OwnableRoles.sol#L488) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L488


 - [ ] ID-542
[OwnableRoles._ROLE_133](lib/solady/src/auth/OwnableRoles.sol#L412) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L412


 - [ ] ID-543
[OwnableRoles._ROLE_144](lib/solady/src/auth/OwnableRoles.sol#L423) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L423


 - [ ] ID-544
[OwnableRoles._ROLE_174](lib/solady/src/auth/OwnableRoles.sol#L453) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L453


 - [ ] ID-545
[OwnableRoles._ROLE_250](lib/solady/src/auth/OwnableRoles.sol#L529) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L529


 - [ ] ID-546
[OwnableRoles._ROLE_255](lib/solady/src/auth/OwnableRoles.sol#L534) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L534


 - [ ] ID-547
[OwnableRoles._ROLE_98](lib/solady/src/auth/OwnableRoles.sol#L377) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L377


 - [ ] ID-548
[OwnableRoles._ROLE_159](lib/solady/src/auth/OwnableRoles.sol#L438) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L438


 - [ ] ID-549
[OwnableRoles._ROLE_1](lib/solady/src/auth/OwnableRoles.sol#L280) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L280


 - [ ] ID-550
[OwnableRoles._ROLE_10](lib/solady/src/auth/OwnableRoles.sol#L289) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L289


 - [ ] ID-551
[OwnableRoles._ROLE_239](lib/solady/src/auth/OwnableRoles.sol#L518) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L518


 - [ ] ID-552
[OwnableRoles._ROLE_151](lib/solady/src/auth/OwnableRoles.sol#L430) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L430


 - [ ] ID-553
[OwnableRoles._ROLE_6](lib/solady/src/auth/OwnableRoles.sol#L285) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L285


 - [ ] ID-554
[OwnableRoles._ROLE_128](lib/solady/src/auth/OwnableRoles.sol#L407) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L407


 - [ ] ID-555
[OwnableRoles._ROLE_172](lib/solady/src/auth/OwnableRoles.sol#L451) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L451


 - [ ] ID-556
[OwnableRoles._ROLE_187](lib/solady/src/auth/OwnableRoles.sol#L466) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L466


 - [ ] ID-557
[OwnableRoles._ROLE_95](lib/solady/src/auth/OwnableRoles.sol#L374) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L374


 - [ ] ID-558
[OwnableRoles._ROLE_176](lib/solady/src/auth/OwnableRoles.sol#L455) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L455


 - [ ] ID-559
[OwnableRoles._ROLE_168](lib/solady/src/auth/OwnableRoles.sol#L447) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L447


 - [ ] ID-560
[OwnableRoles._ROLE_244](lib/solady/src/auth/OwnableRoles.sol#L523) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L523


 - [ ] ID-561
[OwnableRoles._ROLE_150](lib/solady/src/auth/OwnableRoles.sol#L429) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L429


 - [ ] ID-562
[OwnableRoles._ROLE_102](lib/solady/src/auth/OwnableRoles.sol#L381) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L381


 - [ ] ID-563
[OwnableRoles._ROLE_180](lib/solady/src/auth/OwnableRoles.sol#L459) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L459


 - [ ] ID-564
[OwnableRoles._ROLE_4](lib/solady/src/auth/OwnableRoles.sol#L283) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L283


 - [ ] ID-565
[OwnableRoles._ROLE_37](lib/solady/src/auth/OwnableRoles.sol#L316) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L316


 - [ ] ID-566
[OwnableRoles._ROLE_224](lib/solady/src/auth/OwnableRoles.sol#L503) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L503


 - [ ] ID-567
[OwnableRoles._ROLE_127](lib/solady/src/auth/OwnableRoles.sol#L406) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L406


 - [ ] ID-568
[OwnableRoles._ROLE_219](lib/solady/src/auth/OwnableRoles.sol#L498) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L498


 - [ ] ID-569
[OwnableRoles._ROLE_121](lib/solady/src/auth/OwnableRoles.sol#L400) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L400


 - [ ] ID-570
[OwnableRoles._ROLE_104](lib/solady/src/auth/OwnableRoles.sol#L383) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L383


 - [ ] ID-571
[OwnableRoles._ROLE_67](lib/solady/src/auth/OwnableRoles.sol#L346) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L346


 - [ ] ID-572
[OwnableRoles._ROLE_194](lib/solady/src/auth/OwnableRoles.sol#L473) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L473


 - [ ] ID-573
[OwnableRoles._ROLE_67](lib/solady/src/auth/OwnableRoles.sol#L346) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L346


 - [ ] ID-574
[OwnableRoles._ROLE_109](lib/solady/src/auth/OwnableRoles.sol#L388) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L388


 - [ ] ID-575
[OwnableRoles._ROLE_226](lib/solady/src/auth/OwnableRoles.sol#L505) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L505


 - [ ] ID-576
[OwnableRoles._ROLE_87](lib/solady/src/auth/OwnableRoles.sol#L366) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L366


 - [ ] ID-577
[OwnableRoles._ROLE_77](lib/solady/src/auth/OwnableRoles.sol#L356) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L356


 - [ ] ID-578
[OwnableRoles._ROLE_140](lib/solady/src/auth/OwnableRoles.sol#L419) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L419


 - [ ] ID-579
[OwnableRoles._ROLE_13](lib/solady/src/auth/OwnableRoles.sol#L292) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L292


 - [ ] ID-580
[OwnableRoles._ROLE_74](lib/solady/src/auth/OwnableRoles.sol#L353) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L353


 - [ ] ID-581
[OwnableRoles._ROLE_136](lib/solady/src/auth/OwnableRoles.sol#L415) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L415


 - [ ] ID-582
[OwnableRoles._ROLE_159](lib/solady/src/auth/OwnableRoles.sol#L438) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L438


 - [ ] ID-583
[OwnableRoles._ROLE_34](lib/solady/src/auth/OwnableRoles.sol#L313) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L313


 - [ ] ID-584
[OwnableRoles._ROLE_19](lib/solady/src/auth/OwnableRoles.sol#L298) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L298


 - [ ] ID-585
[OwnableRoles._ROLE_110](lib/solady/src/auth/OwnableRoles.sol#L389) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L389


 - [ ] ID-586
[OwnableRoles._ROLE_14](lib/solady/src/auth/OwnableRoles.sol#L293) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L293


 - [ ] ID-587
[OwnableRoles._ROLE_24](lib/solady/src/auth/OwnableRoles.sol#L303) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L303


 - [ ] ID-588
[OwnableRoles._ROLE_107](lib/solady/src/auth/OwnableRoles.sol#L386) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L386


 - [ ] ID-589
[OwnableRoles._ROLE_133](lib/solady/src/auth/OwnableRoles.sol#L412) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L412


 - [ ] ID-590
[OwnableRoles._ROLE_54](lib/solady/src/auth/OwnableRoles.sol#L333) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L333


 - [ ] ID-591
[OwnableRoles._ROLE_15](lib/solady/src/auth/OwnableRoles.sol#L294) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L294


 - [ ] ID-592
[OwnableRoles._ROLE_13](lib/solady/src/auth/OwnableRoles.sol#L292) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L292


 - [ ] ID-593
[OwnableRoles._ROLE_62](lib/solady/src/auth/OwnableRoles.sol#L341) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L341


 - [ ] ID-594
[OwnableRoles._ROLE_58](lib/solady/src/auth/OwnableRoles.sol#L337) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L337


 - [ ] ID-595
[OwnableRoles._ROLE_49](lib/solady/src/auth/OwnableRoles.sol#L328) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L328


 - [ ] ID-596
[OwnableRoles._ROLE_112](lib/solady/src/auth/OwnableRoles.sol#L391) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L391


 - [ ] ID-597
[OwnableRoles._ROLE_12](lib/solady/src/auth/OwnableRoles.sol#L291) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L291


 - [ ] ID-598
[OwnableRoles._ROLE_55](lib/solady/src/auth/OwnableRoles.sol#L334) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L334


 - [ ] ID-599
[OwnableRoles._ROLE_189](lib/solady/src/auth/OwnableRoles.sol#L468) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L468


 - [ ] ID-600
[OwnableRoles._ROLE_218](lib/solady/src/auth/OwnableRoles.sol#L497) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L497


 - [ ] ID-601
[OwnableRoles._ROLE_29](lib/solady/src/auth/OwnableRoles.sol#L308) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L308


 - [ ] ID-602
[OwnableRoles._ROLE_84](lib/solady/src/auth/OwnableRoles.sol#L363) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L363


 - [ ] ID-603
[OwnableRoles._ROLE_184](lib/solady/src/auth/OwnableRoles.sol#L463) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L463


 - [ ] ID-604
[OwnableRoles._ROLE_52](lib/solady/src/auth/OwnableRoles.sol#L331) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L331


 - [ ] ID-605
[OwnableRoles._ROLE_2](lib/solady/src/auth/OwnableRoles.sol#L281) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L281


 - [ ] ID-606
[OwnableRoles._ROLE_97](lib/solady/src/auth/OwnableRoles.sol#L376) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L376


 - [ ] ID-607
[OwnableRoles._ROLE_210](lib/solady/src/auth/OwnableRoles.sol#L489) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L489


 - [ ] ID-608
[OwnableRoles._ROLE_137](lib/solady/src/auth/OwnableRoles.sol#L416) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L416


 - [ ] ID-609
[OwnableRoles._ROLE_231](lib/solady/src/auth/OwnableRoles.sol#L510) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L510


 - [ ] ID-610
[OwnableRoles._ROLE_213](lib/solady/src/auth/OwnableRoles.sol#L492) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L492


 - [ ] ID-611
[OwnableRoles._ROLE_32](lib/solady/src/auth/OwnableRoles.sol#L311) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L311


 - [ ] ID-612
[OwnableRoles._ROLE_246](lib/solady/src/auth/OwnableRoles.sol#L525) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L525


 - [ ] ID-613
[OwnableRoles._ROLE_211](lib/solady/src/auth/OwnableRoles.sol#L490) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L490


 - [ ] ID-614
[OwnableRoles._ROLE_252](lib/solady/src/auth/OwnableRoles.sol#L531) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L531


 - [ ] ID-615
[OwnableRoles._ROLE_76](lib/solady/src/auth/OwnableRoles.sol#L355) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L355


 - [ ] ID-616
[OwnableRoles._ROLE_175](lib/solady/src/auth/OwnableRoles.sol#L454) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L454


 - [ ] ID-617
[OwnableRoles._ROLE_224](lib/solady/src/auth/OwnableRoles.sol#L503) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L503


 - [ ] ID-618
[OwnableRoles._ROLE_160](lib/solady/src/auth/OwnableRoles.sol#L439) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L439


 - [ ] ID-619
[OwnableRoles._ROLE_220](lib/solady/src/auth/OwnableRoles.sol#L499) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L499


 - [ ] ID-620
[OwnableRoles._ROLE_9](lib/solady/src/auth/OwnableRoles.sol#L288) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L288


 - [ ] ID-621
[OwnableRoles._ROLE_171](lib/solady/src/auth/OwnableRoles.sol#L450) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L450


 - [ ] ID-622
[OwnableRoles._ROLE_230](lib/solady/src/auth/OwnableRoles.sol#L509) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L509


 - [ ] ID-623
[OwnableRoles._ROLE_134](lib/solady/src/auth/OwnableRoles.sol#L413) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L413


 - [ ] ID-624
[OwnableRoles._ROLE_119](lib/solady/src/auth/OwnableRoles.sol#L398) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L398


 - [ ] ID-625
[OwnableRoles._ROLE_220](lib/solady/src/auth/OwnableRoles.sol#L499) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L499


 - [ ] ID-626
[OwnableRoles._ROLE_228](lib/solady/src/auth/OwnableRoles.sol#L507) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L507


 - [ ] ID-627
[OwnableRoles._ROLE_139](lib/solady/src/auth/OwnableRoles.sol#L418) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L418


 - [ ] ID-628
[OwnableRoles._ROLE_244](lib/solady/src/auth/OwnableRoles.sol#L523) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L523


 - [ ] ID-629
[OwnableRoles._ROLE_3](lib/solady/src/auth/OwnableRoles.sol#L282) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L282


 - [ ] ID-630
[OwnableRoles._ROLE_190](lib/solady/src/auth/OwnableRoles.sol#L469) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L469


 - [ ] ID-631
[OwnableRoles._ROLE_91](lib/solady/src/auth/OwnableRoles.sol#L370) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L370


 - [ ] ID-632
[OwnableRoles._ROLE_38](lib/solady/src/auth/OwnableRoles.sol#L317) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L317


 - [ ] ID-633
[OwnableRoles._ROLE_66](lib/solady/src/auth/OwnableRoles.sol#L345) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L345


 - [ ] ID-634
[OwnableRoles._ROLE_167](lib/solady/src/auth/OwnableRoles.sol#L446) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L446


 - [ ] ID-635
[OwnableRoles._ROLE_122](lib/solady/src/auth/OwnableRoles.sol#L401) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L401


 - [ ] ID-636
[OwnableRoles._ROLE_60](lib/solady/src/auth/OwnableRoles.sol#L339) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L339


 - [ ] ID-637
[OwnableRoles._ROLE_39](lib/solady/src/auth/OwnableRoles.sol#L318) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L318


 - [ ] ID-638
[OwnableRoles._ROLE_142](lib/solady/src/auth/OwnableRoles.sol#L421) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L421


 - [ ] ID-639
[OwnableRoles._ROLE_123](lib/solady/src/auth/OwnableRoles.sol#L402) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L402


 - [ ] ID-640
[OwnableRoles._ROLE_64](lib/solady/src/auth/OwnableRoles.sol#L343) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L343


 - [ ] ID-641
[OwnableRoles._ROLE_167](lib/solady/src/auth/OwnableRoles.sol#L446) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L446


 - [ ] ID-642
[OwnableRoles._ROLE_145](lib/solady/src/auth/OwnableRoles.sol#L424) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L424


 - [ ] ID-643
[OwnableRoles._ROLE_198](lib/solady/src/auth/OwnableRoles.sol#L477) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L477


 - [ ] ID-644
[OwnableRoles._ROLE_196](lib/solady/src/auth/OwnableRoles.sol#L475) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L475


 - [ ] ID-645
[OwnableRoles._ROLE_207](lib/solady/src/auth/OwnableRoles.sol#L486) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L486


 - [ ] ID-646
[OwnableRoles._ROLE_170](lib/solady/src/auth/OwnableRoles.sol#L449) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L449


 - [ ] ID-647
[OwnableRoles._ROLE_128](lib/solady/src/auth/OwnableRoles.sol#L407) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L407


 - [ ] ID-648
[OwnableRoles._ROLE_8](lib/solady/src/auth/OwnableRoles.sol#L287) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L287


 - [ ] ID-649
[OwnableRoles._ROLE_71](lib/solady/src/auth/OwnableRoles.sol#L350) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L350


 - [ ] ID-650
[OwnableRoles._ROLE_139](lib/solady/src/auth/OwnableRoles.sol#L418) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L418


 - [ ] ID-651
[OwnableRoles._ROLE_42](lib/solady/src/auth/OwnableRoles.sol#L321) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L321


 - [ ] ID-652
[OwnableRoles._ROLE_151](lib/solady/src/auth/OwnableRoles.sol#L430) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L430


 - [ ] ID-653
[OwnableRoles._ROLE_251](lib/solady/src/auth/OwnableRoles.sol#L530) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L530


 - [ ] ID-654
[OwnableRoles._ROLE_74](lib/solady/src/auth/OwnableRoles.sol#L353) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L353


 - [ ] ID-655
[OwnableRoles._ROLE_138](lib/solady/src/auth/OwnableRoles.sol#L417) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L417


 - [ ] ID-656
[OwnableRoles._ROLE_24](lib/solady/src/auth/OwnableRoles.sol#L303) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L303


 - [ ] ID-657
[OwnableRoles._ROLE_35](lib/solady/src/auth/OwnableRoles.sol#L314) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L314


 - [ ] ID-658
[OwnableRoles._ROLE_130](lib/solady/src/auth/OwnableRoles.sol#L409) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L409


 - [ ] ID-659
[OwnableRoles._ROLE_135](lib/solady/src/auth/OwnableRoles.sol#L414) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L414


 - [ ] ID-660
[OwnableRoles._ROLE_133](lib/solady/src/auth/OwnableRoles.sol#L412) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L412


 - [ ] ID-661
[OwnableRoles._ROLE_175](lib/solady/src/auth/OwnableRoles.sol#L454) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L454


 - [ ] ID-662
[OwnableRoles._ROLE_140](lib/solady/src/auth/OwnableRoles.sol#L419) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L419


 - [ ] ID-663
[OwnableRoles._ROLE_107](lib/solady/src/auth/OwnableRoles.sol#L386) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L386


 - [ ] ID-664
[OwnableRoles._ROLE_68](lib/solady/src/auth/OwnableRoles.sol#L347) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L347


 - [ ] ID-665
[OwnableRoles._ROLE_245](lib/solady/src/auth/OwnableRoles.sol#L524) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L524


 - [ ] ID-666
[OwnableRoles._ROLE_233](lib/solady/src/auth/OwnableRoles.sol#L512) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L512


 - [ ] ID-667
[OwnableRoles._ROLE_17](lib/solady/src/auth/OwnableRoles.sol#L296) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L296


 - [ ] ID-668
[OwnableRoles._ROLE_106](lib/solady/src/auth/OwnableRoles.sol#L385) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L385


 - [ ] ID-669
[OwnableRoles._ROLE_123](lib/solady/src/auth/OwnableRoles.sol#L402) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L402


 - [ ] ID-670
[OwnableRoles._ROLE_196](lib/solady/src/auth/OwnableRoles.sol#L475) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L475


 - [ ] ID-671
[OwnableRoles._ROLE_119](lib/solady/src/auth/OwnableRoles.sol#L398) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L398


 - [ ] ID-672
[OwnableRoles._ROLE_88](lib/solady/src/auth/OwnableRoles.sol#L367) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L367


 - [ ] ID-673
[OwnableRoles._ROLE_195](lib/solady/src/auth/OwnableRoles.sol#L474) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L474


 - [ ] ID-674
[OwnableRoles._ROLE_59](lib/solady/src/auth/OwnableRoles.sol#L338) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L338


 - [ ] ID-675
[OwnableRoles._ROLE_132](lib/solady/src/auth/OwnableRoles.sol#L411) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L411


 - [ ] ID-676
[OwnableRoles._ROLE_138](lib/solady/src/auth/OwnableRoles.sol#L417) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L417


 - [ ] ID-677
[OwnableRoles._ROLE_19](lib/solady/src/auth/OwnableRoles.sol#L298) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L298


 - [ ] ID-678
[OwnableRoles._ROLE_1](lib/solady/src/auth/OwnableRoles.sol#L280) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L280


 - [ ] ID-679
[OwnableRoles._ROLE_169](lib/solady/src/auth/OwnableRoles.sol#L448) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L448


 - [ ] ID-680
[OwnableRoles._ROLE_127](lib/solady/src/auth/OwnableRoles.sol#L406) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L406


 - [ ] ID-681
[OwnableRoles._ROLE_184](lib/solady/src/auth/OwnableRoles.sol#L463) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L463


 - [ ] ID-682
[OwnableRoles._ROLE_229](lib/solady/src/auth/OwnableRoles.sol#L508) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L508


 - [ ] ID-683
[OwnableRoles._ROLE_197](lib/solady/src/auth/OwnableRoles.sol#L476) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L476


 - [ ] ID-684
[OwnableRoles._ROLE_199](lib/solady/src/auth/OwnableRoles.sol#L478) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L478


 - [ ] ID-685
[OwnableRoles._ROLE_248](lib/solady/src/auth/OwnableRoles.sol#L527) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L527


 - [ ] ID-686
[OwnableRoles._ROLE_135](lib/solady/src/auth/OwnableRoles.sol#L414) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L414


 - [ ] ID-687
[OwnableRoles._ROLE_60](lib/solady/src/auth/OwnableRoles.sol#L339) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L339


 - [ ] ID-688
[OwnableRoles._ROLE_2](lib/solady/src/auth/OwnableRoles.sol#L281) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L281


 - [ ] ID-689
[OwnableRoles._ROLE_74](lib/solady/src/auth/OwnableRoles.sol#L353) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L353


 - [ ] ID-690
[OwnableRoles._ROLE_205](lib/solady/src/auth/OwnableRoles.sol#L484) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L484


 - [ ] ID-691
[OwnableRoles._ROLE_98](lib/solady/src/auth/OwnableRoles.sol#L377) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L377


 - [ ] ID-692
[OwnableRoles._ROLE_42](lib/solady/src/auth/OwnableRoles.sol#L321) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L321


 - [ ] ID-693
[OwnableRoles._ROLE_249](lib/solady/src/auth/OwnableRoles.sol#L528) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L528


 - [ ] ID-694
[OwnableRoles._ROLE_150](lib/solady/src/auth/OwnableRoles.sol#L429) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L429


 - [ ] ID-695
[OwnableRoles._ROLE_28](lib/solady/src/auth/OwnableRoles.sol#L307) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L307


 - [ ] ID-696
[OwnableRoles._ROLE_132](lib/solady/src/auth/OwnableRoles.sol#L411) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L411


 - [ ] ID-697
[OwnableRoles._ROLE_51](lib/solady/src/auth/OwnableRoles.sol#L330) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L330


 - [ ] ID-698
[OwnableRoles._ROLE_245](lib/solady/src/auth/OwnableRoles.sol#L524) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L524


 - [ ] ID-699
[OwnableRoles._ROLE_156](lib/solady/src/auth/OwnableRoles.sol#L435) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L435


 - [ ] ID-700
[OwnableRoles._ROLE_170](lib/solady/src/auth/OwnableRoles.sol#L449) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L449


 - [ ] ID-701
[OwnableRoles._ROLE_8](lib/solady/src/auth/OwnableRoles.sol#L287) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L287


 - [ ] ID-702
[OwnableRoles._ROLE_135](lib/solady/src/auth/OwnableRoles.sol#L414) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L414


 - [ ] ID-703
[OwnableRoles._ROLE_208](lib/solady/src/auth/OwnableRoles.sol#L487) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L487


 - [ ] ID-704
[OwnableRoles._ROLE_141](lib/solady/src/auth/OwnableRoles.sol#L420) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L420


 - [ ] ID-705
[OwnableRoles._ROLE_41](lib/solady/src/auth/OwnableRoles.sol#L320) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L320


 - [ ] ID-706
[OwnableRoles._ROLE_89](lib/solady/src/auth/OwnableRoles.sol#L368) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L368


 - [ ] ID-707
[OwnableRoles._ROLE_152](lib/solady/src/auth/OwnableRoles.sol#L431) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L431


 - [ ] ID-708
[OwnableRoles._ROLE_215](lib/solady/src/auth/OwnableRoles.sol#L494) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L494


 - [ ] ID-709
[OwnableRoles._ROLE_84](lib/solady/src/auth/OwnableRoles.sol#L363) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L363


 - [ ] ID-710
[OwnableRoles._ROLE_170](lib/solady/src/auth/OwnableRoles.sol#L449) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L449


 - [ ] ID-711
[OwnableRoles._ROLE_93](lib/solady/src/auth/OwnableRoles.sol#L372) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L372


 - [ ] ID-712
[OwnableRoles._ROLE_92](lib/solady/src/auth/OwnableRoles.sol#L371) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L371


 - [ ] ID-713
[OwnableRoles._ROLE_85](lib/solady/src/auth/OwnableRoles.sol#L364) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L364


 - [ ] ID-714
[OwnableRoles._ROLE_168](lib/solady/src/auth/OwnableRoles.sol#L447) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L447


 - [ ] ID-715
[OwnableRoles._ROLE_147](lib/solady/src/auth/OwnableRoles.sol#L426) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L426


 - [ ] ID-716
[OwnableRoles._ROLE_11](lib/solady/src/auth/OwnableRoles.sol#L290) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L290


 - [ ] ID-717
[OwnableRoles._ROLE_229](lib/solady/src/auth/OwnableRoles.sol#L508) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L508


 - [ ] ID-718
[OwnableRoles._ROLE_177](lib/solady/src/auth/OwnableRoles.sol#L456) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L456


 - [ ] ID-719
[OwnableRoles._ROLE_111](lib/solady/src/auth/OwnableRoles.sol#L390) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L390


 - [ ] ID-720
[OwnableRoles._ROLE_157](lib/solady/src/auth/OwnableRoles.sol#L436) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L436


 - [ ] ID-721
[OwnableRoles._ROLE_48](lib/solady/src/auth/OwnableRoles.sol#L327) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L327


 - [ ] ID-722
[OwnableRoles._ROLE_207](lib/solady/src/auth/OwnableRoles.sol#L486) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L486


 - [ ] ID-723
[OwnableRoles._ROLE_158](lib/solady/src/auth/OwnableRoles.sol#L437) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L437


 - [ ] ID-724
[OwnableRoles._ROLE_136](lib/solady/src/auth/OwnableRoles.sol#L415) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L415


 - [ ] ID-725
[OwnableRoles._ROLE_163](lib/solady/src/auth/OwnableRoles.sol#L442) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L442


 - [ ] ID-726
[OwnableRoles._ROLE_169](lib/solady/src/auth/OwnableRoles.sol#L448) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L448


 - [ ] ID-727
[OwnableRoles._ROLE_155](lib/solady/src/auth/OwnableRoles.sol#L434) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L434


 - [ ] ID-728
[OwnableRoles._ROLE_161](lib/solady/src/auth/OwnableRoles.sol#L440) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L440


 - [ ] ID-729
[OwnableRoles._ROLE_3](lib/solady/src/auth/OwnableRoles.sol#L282) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L282


 - [ ] ID-730
[OwnableRoles._ROLE_236](lib/solady/src/auth/OwnableRoles.sol#L515) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L515


 - [ ] ID-731
[OwnableRoles._ROLE_241](lib/solady/src/auth/OwnableRoles.sol#L520) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L520


 - [ ] ID-732
[OwnableRoles._ROLE_193](lib/solady/src/auth/OwnableRoles.sol#L472) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L472


 - [ ] ID-733
[OwnableRoles._ROLE_235](lib/solady/src/auth/OwnableRoles.sol#L514) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L514


 - [ ] ID-734
[OwnableRoles._ROLE_213](lib/solady/src/auth/OwnableRoles.sol#L492) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L492


 - [ ] ID-735
[OwnableRoles._ROLE_87](lib/solady/src/auth/OwnableRoles.sol#L366) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L366


 - [ ] ID-736
[OwnableRoles._ROLE_99](lib/solady/src/auth/OwnableRoles.sol#L378) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L378


 - [ ] ID-737
[OwnableRoles._ROLE_204](lib/solady/src/auth/OwnableRoles.sol#L483) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L483


 - [ ] ID-738
[OwnableRoles._ROLE_125](lib/solady/src/auth/OwnableRoles.sol#L404) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L404


 - [ ] ID-739
[OwnableRoles._ROLE_178](lib/solady/src/auth/OwnableRoles.sol#L457) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L457


 - [ ] ID-740
[OwnableRoles._ROLE_221](lib/solady/src/auth/OwnableRoles.sol#L500) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L500


 - [ ] ID-741
[OwnableRoles._ROLE_6](lib/solady/src/auth/OwnableRoles.sol#L285) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L285


 - [ ] ID-742
[OwnableRoles._ROLE_62](lib/solady/src/auth/OwnableRoles.sol#L341) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L341


 - [ ] ID-743
[OwnableRoles._ROLE_109](lib/solady/src/auth/OwnableRoles.sol#L388) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L388


 - [ ] ID-744
[OwnableRoles._ROLE_45](lib/solady/src/auth/OwnableRoles.sol#L324) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L324


 - [ ] ID-745
[OwnableRoles._ROLE_94](lib/solady/src/auth/OwnableRoles.sol#L373) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L373


 - [ ] ID-746
[OwnableRoles._ROLE_222](lib/solady/src/auth/OwnableRoles.sol#L501) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L501


 - [ ] ID-747
[OwnableRoles._ROLE_41](lib/solady/src/auth/OwnableRoles.sol#L320) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L320


 - [ ] ID-748
[OwnableRoles._ROLE_237](lib/solady/src/auth/OwnableRoles.sol#L516) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L516


 - [ ] ID-749
[OwnableRoles._ROLE_190](lib/solady/src/auth/OwnableRoles.sol#L469) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L469


 - [ ] ID-750
[OwnableRoles._ROLE_85](lib/solady/src/auth/OwnableRoles.sol#L364) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L364


 - [ ] ID-751
[OwnableRoles._ROLE_154](lib/solady/src/auth/OwnableRoles.sol#L433) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L433


 - [ ] ID-752
[OwnableRoles._ROLE_28](lib/solady/src/auth/OwnableRoles.sol#L307) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L307


 - [ ] ID-753
[OwnableRoles._ROLE_191](lib/solady/src/auth/OwnableRoles.sol#L470) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L470


 - [ ] ID-754
[OwnableRoles._ROLE_47](lib/solady/src/auth/OwnableRoles.sol#L326) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L326


 - [ ] ID-755
[OwnableRoles._ROLE_204](lib/solady/src/auth/OwnableRoles.sol#L483) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L483


 - [ ] ID-756
[OwnableRoles._ROLE_51](lib/solady/src/auth/OwnableRoles.sol#L330) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L330


 - [ ] ID-757
[OwnableRoles._ROLE_185](lib/solady/src/auth/OwnableRoles.sol#L464) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L464


 - [ ] ID-758
[OwnableRoles._ROLE_4](lib/solady/src/auth/OwnableRoles.sol#L283) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L283


 - [ ] ID-759
[OwnableRoles._ROLE_7](lib/solady/src/auth/OwnableRoles.sol#L286) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L286


 - [ ] ID-760
[OwnableRoles._ROLE_219](lib/solady/src/auth/OwnableRoles.sol#L498) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L498


 - [ ] ID-761
[OwnableRoles._ROLE_183](lib/solady/src/auth/OwnableRoles.sol#L462) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L462


 - [ ] ID-762
[OwnableRoles._ROLE_43](lib/solady/src/auth/OwnableRoles.sol#L322) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L322


 - [ ] ID-763
[OwnableRoles._ROLE_102](lib/solady/src/auth/OwnableRoles.sol#L381) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L381


 - [ ] ID-764
[OwnableRoles._ROLE_112](lib/solady/src/auth/OwnableRoles.sol#L391) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L391


 - [ ] ID-765
[OwnableRoles._ROLE_90](lib/solady/src/auth/OwnableRoles.sol#L369) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L369


 - [ ] ID-766
[OwnableRoles._ROLE_222](lib/solady/src/auth/OwnableRoles.sol#L501) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L501


 - [ ] ID-767
[OwnableRoles._ROLE_23](lib/solady/src/auth/OwnableRoles.sol#L302) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L302


 - [ ] ID-768
[OwnableRoles._ROLE_165](lib/solady/src/auth/OwnableRoles.sol#L444) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L444


 - [ ] ID-769
[OwnableRoles._ROLE_16](lib/solady/src/auth/OwnableRoles.sol#L295) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L295


 - [ ] ID-770
[OwnableRoles._ROLE_172](lib/solady/src/auth/OwnableRoles.sol#L451) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L451


 - [ ] ID-771
[OwnableRoles._ROLE_75](lib/solady/src/auth/OwnableRoles.sol#L354) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L354


 - [ ] ID-772
[OwnableRoles._ROLE_118](lib/solady/src/auth/OwnableRoles.sol#L397) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L397


 - [ ] ID-773
[OwnableRoles._ROLE_121](lib/solady/src/auth/OwnableRoles.sol#L400) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L400


 - [ ] ID-774
[OwnableRoles._ROLE_50](lib/solady/src/auth/OwnableRoles.sol#L329) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L329


 - [ ] ID-775
[OwnableRoles._ROLE_24](lib/solady/src/auth/OwnableRoles.sol#L303) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L303


 - [ ] ID-776
[OwnableRoles._ROLE_40](lib/solady/src/auth/OwnableRoles.sol#L319) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L319


 - [ ] ID-777
[OwnableRoles._ROLE_199](lib/solady/src/auth/OwnableRoles.sol#L478) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L478


 - [ ] ID-778
[OwnableRoles._ROLE_181](lib/solady/src/auth/OwnableRoles.sol#L460) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L460


 - [ ] ID-779
[OwnableRoles._ROLE_121](lib/solady/src/auth/OwnableRoles.sol#L400) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L400


 - [ ] ID-780
[OwnableRoles._ROLE_29](lib/solady/src/auth/OwnableRoles.sol#L308) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L308


 - [ ] ID-781
[OwnableRoles._ROLE_105](lib/solady/src/auth/OwnableRoles.sol#L384) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L384


 - [ ] ID-782
[OwnableRoles._ROLE_190](lib/solady/src/auth/OwnableRoles.sol#L469) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L469


 - [ ] ID-783
[OwnableRoles._ROLE_161](lib/solady/src/auth/OwnableRoles.sol#L440) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L440


 - [ ] ID-784
[OwnableRoles._ROLE_29](lib/solady/src/auth/OwnableRoles.sol#L308) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L308


 - [ ] ID-785
[OwnableRoles._ROLE_35](lib/solady/src/auth/OwnableRoles.sol#L314) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L314


 - [ ] ID-786
[OwnableRoles._ROLE_246](lib/solady/src/auth/OwnableRoles.sol#L525) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L525


 - [ ] ID-787
[OwnableRoles._ROLE_188](lib/solady/src/auth/OwnableRoles.sol#L467) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L467


 - [ ] ID-788
[OwnableRoles._ROLE_35](lib/solady/src/auth/OwnableRoles.sol#L314) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L314


 - [ ] ID-789
[OwnableRoles._ROLE_220](lib/solady/src/auth/OwnableRoles.sol#L499) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L499


 - [ ] ID-790
[OwnableRoles._ROLE_156](lib/solady/src/auth/OwnableRoles.sol#L435) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L435


 - [ ] ID-791
[OwnableRoles._ROLE_253](lib/solady/src/auth/OwnableRoles.sol#L532) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L532


 - [ ] ID-792
[OwnableRoles._ROLE_233](lib/solady/src/auth/OwnableRoles.sol#L512) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L512


 - [ ] ID-793
[OwnableRoles._ROLE_26](lib/solady/src/auth/OwnableRoles.sol#L305) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L305


 - [ ] ID-794
[OwnableRoles._ROLE_63](lib/solady/src/auth/OwnableRoles.sol#L342) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L342


 - [ ] ID-795
[OwnableRoles._ROLE_104](lib/solady/src/auth/OwnableRoles.sol#L383) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L383


 - [ ] ID-796
[OwnableRoles._ROLE_30](lib/solady/src/auth/OwnableRoles.sol#L309) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L309


 - [ ] ID-797
[OwnableRoles._ROLE_148](lib/solady/src/auth/OwnableRoles.sol#L427) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L427


 - [ ] ID-798
[OwnableRoles._ROLE_203](lib/solady/src/auth/OwnableRoles.sol#L482) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L482


 - [ ] ID-799
[OwnableRoles._ROLE_17](lib/solady/src/auth/OwnableRoles.sol#L296) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L296


 - [ ] ID-800
[OwnableRoles._ROLE_86](lib/solady/src/auth/OwnableRoles.sol#L365) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L365


 - [ ] ID-801
[OwnableRoles._ROLE_201](lib/solady/src/auth/OwnableRoles.sol#L480) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L480


 - [ ] ID-802
[OwnableRoles._ROLE_168](lib/solady/src/auth/OwnableRoles.sol#L447) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L447


 - [ ] ID-803
[OwnableRoles._ROLE_69](lib/solady/src/auth/OwnableRoles.sol#L348) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L348


 - [ ] ID-804
[OwnableRoles._ROLE_192](lib/solady/src/auth/OwnableRoles.sol#L471) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L471


 - [ ] ID-805
[OwnableRoles._ROLE_201](lib/solady/src/auth/OwnableRoles.sol#L480) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L480


 - [ ] ID-806
[OwnableRoles._ROLE_61](lib/solady/src/auth/OwnableRoles.sol#L340) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L340


 - [ ] ID-807
[OwnableRoles._ROLE_25](lib/solady/src/auth/OwnableRoles.sol#L304) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L304


 - [ ] ID-808
[OwnableRoles._ROLE_21](lib/solady/src/auth/OwnableRoles.sol#L300) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L300


 - [ ] ID-809
[OwnableRoles._ROLE_113](lib/solady/src/auth/OwnableRoles.sol#L392) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L392


 - [ ] ID-810
[OwnableRoles._ROLE_200](lib/solady/src/auth/OwnableRoles.sol#L479) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L479


 - [ ] ID-811
[OwnableRoles._ROLE_138](lib/solady/src/auth/OwnableRoles.sol#L417) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L417


 - [ ] ID-812
[OwnableRoles._ROLE_209](lib/solady/src/auth/OwnableRoles.sol#L488) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L488


 - [ ] ID-813
[OwnableRoles._ROLE_45](lib/solady/src/auth/OwnableRoles.sol#L324) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L324


 - [ ] ID-814
[OwnableRoles._ROLE_11](lib/solady/src/auth/OwnableRoles.sol#L290) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L290


 - [ ] ID-815
[OwnableRoles._ROLE_52](lib/solady/src/auth/OwnableRoles.sol#L331) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L331


 - [ ] ID-816
[OwnableRoles._ROLE_143](lib/solady/src/auth/OwnableRoles.sol#L422) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L422


 - [ ] ID-817
[OwnableRoles._ROLE_114](lib/solady/src/auth/OwnableRoles.sol#L393) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L393


 - [ ] ID-818
[OwnableRoles._ROLE_115](lib/solady/src/auth/OwnableRoles.sol#L394) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L394


 - [ ] ID-819
[OwnableRoles._ROLE_43](lib/solady/src/auth/OwnableRoles.sol#L322) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L322


 - [ ] ID-820
[OwnableRoles._ROLE_177](lib/solady/src/auth/OwnableRoles.sol#L456) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L456


 - [ ] ID-821
[OwnableRoles._ROLE_72](lib/solady/src/auth/OwnableRoles.sol#L351) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L351


 - [ ] ID-822
[OwnableRoles._ROLE_188](lib/solady/src/auth/OwnableRoles.sol#L467) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L467


 - [ ] ID-823
[OwnableRoles._ROLE_26](lib/solady/src/auth/OwnableRoles.sol#L305) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L305


 - [ ] ID-824
[OwnableRoles._ROLE_254](lib/solady/src/auth/OwnableRoles.sol#L533) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L533


 - [ ] ID-825
[OwnableRoles._ROLE_46](lib/solady/src/auth/OwnableRoles.sol#L325) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L325


 - [ ] ID-826
[OwnableRoles._ROLE_21](lib/solady/src/auth/OwnableRoles.sol#L300) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L300


 - [ ] ID-827
[OwnableRoles._ROLE_63](lib/solady/src/auth/OwnableRoles.sol#L342) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L342


 - [ ] ID-828
[OwnableRoles._ROLE_96](lib/solady/src/auth/OwnableRoles.sol#L375) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L375


 - [ ] ID-829
[OwnableRoles._ROLE_223](lib/solady/src/auth/OwnableRoles.sol#L502) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L502


 - [ ] ID-830
[OwnableRoles._ROLE_114](lib/solady/src/auth/OwnableRoles.sol#L393) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L393


 - [ ] ID-831
[OwnableRoles._ROLE_206](lib/solady/src/auth/OwnableRoles.sol#L485) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L485


 - [ ] ID-832
[OwnableRoles._ROLE_25](lib/solady/src/auth/OwnableRoles.sol#L304) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L304


 - [ ] ID-833
[OwnableRoles._ROLE_166](lib/solady/src/auth/OwnableRoles.sol#L445) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L445


 - [ ] ID-834
[OwnableRoles._ROLE_36](lib/solady/src/auth/OwnableRoles.sol#L315) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L315


 - [ ] ID-835
[OwnableRoles._ROLE_116](lib/solady/src/auth/OwnableRoles.sol#L395) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L395


 - [ ] ID-836
[OwnableRoles._ROLE_18](lib/solady/src/auth/OwnableRoles.sol#L297) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L297


 - [ ] ID-837
[OwnableRoles._ROLE_254](lib/solady/src/auth/OwnableRoles.sol#L533) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L533


 - [ ] ID-838
[OwnableRoles._ROLE_174](lib/solady/src/auth/OwnableRoles.sol#L453) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L453


 - [ ] ID-839
[OwnableRoles._ROLE_68](lib/solady/src/auth/OwnableRoles.sol#L347) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L347


 - [ ] ID-840
[OwnableRoles._ROLE_149](lib/solady/src/auth/OwnableRoles.sol#L428) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L428


 - [ ] ID-841
[OwnableRoles._ROLE_66](lib/solady/src/auth/OwnableRoles.sol#L345) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L345


 - [ ] ID-842
[OwnableRoles._ROLE_240](lib/solady/src/auth/OwnableRoles.sol#L519) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L519


 - [ ] ID-843
[OwnableRoles._ROLE_179](lib/solady/src/auth/OwnableRoles.sol#L458) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L458


 - [ ] ID-844
[OwnableRoles._ROLE_79](lib/solady/src/auth/OwnableRoles.sol#L358) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L358


 - [ ] ID-845
[OwnableRoles._ROLE_181](lib/solady/src/auth/OwnableRoles.sol#L460) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L460


 - [ ] ID-846
[OwnableRoles._ROLE_45](lib/solady/src/auth/OwnableRoles.sol#L324) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L324


 - [ ] ID-847
[OwnableRoles._ROLE_78](lib/solady/src/auth/OwnableRoles.sol#L357) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L357


 - [ ] ID-848
[OwnableRoles._ROLE_216](lib/solady/src/auth/OwnableRoles.sol#L495) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L495


 - [ ] ID-849
[OwnableRoles._ROLE_27](lib/solady/src/auth/OwnableRoles.sol#L306) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L306


 - [ ] ID-850
[OwnableRoles._ROLE_5](lib/solady/src/auth/OwnableRoles.sol#L284) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L284


 - [ ] ID-851
[OwnableRoles._ROLE_202](lib/solady/src/auth/OwnableRoles.sol#L481) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L481


 - [ ] ID-852
[OwnableRoles._ROLE_68](lib/solady/src/auth/OwnableRoles.sol#L347) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L347


 - [ ] ID-853
[OwnableRoles._ROLE_78](lib/solady/src/auth/OwnableRoles.sol#L357) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L357


 - [ ] ID-854
[OwnableRoles._ROLE_236](lib/solady/src/auth/OwnableRoles.sol#L515) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L515


 - [ ] ID-855
[OwnableRoles._ROLE_92](lib/solady/src/auth/OwnableRoles.sol#L371) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L371


 - [ ] ID-856
[OwnableRoles._ROLE_71](lib/solady/src/auth/OwnableRoles.sol#L350) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L350


 - [ ] ID-857
[OwnableRoles._ROLE_212](lib/solady/src/auth/OwnableRoles.sol#L491) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L491


 - [ ] ID-858
[OwnableRoles._ROLE_146](lib/solady/src/auth/OwnableRoles.sol#L425) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L425


 - [ ] ID-859
[OwnableRoles._ROLE_43](lib/solady/src/auth/OwnableRoles.sol#L322) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L322


 - [ ] ID-860
[OwnableRoles._ROLE_218](lib/solady/src/auth/OwnableRoles.sol#L497) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L497


 - [ ] ID-861
[OwnableRoles._ROLE_126](lib/solady/src/auth/OwnableRoles.sol#L405) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L405


 - [ ] ID-862
[OwnableRoles._ROLE_154](lib/solady/src/auth/OwnableRoles.sol#L433) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L433


 - [ ] ID-863
[OwnableRoles._ROLE_227](lib/solady/src/auth/OwnableRoles.sol#L506) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L506


 - [ ] ID-864
[OwnableRoles._ROLE_156](lib/solady/src/auth/OwnableRoles.sol#L435) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L435


 - [ ] ID-865
[OwnableRoles._ROLE_147](lib/solady/src/auth/OwnableRoles.sol#L426) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L426


 - [ ] ID-866
[OwnableRoles._ROLE_9](lib/solady/src/auth/OwnableRoles.sol#L288) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L288


 - [ ] ID-867
[OwnableRoles._ROLE_115](lib/solady/src/auth/OwnableRoles.sol#L394) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L394


 - [ ] ID-868
[OwnableRoles._ROLE_118](lib/solady/src/auth/OwnableRoles.sol#L397) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L397


 - [ ] ID-869
[OwnableRoles._ROLE_221](lib/solady/src/auth/OwnableRoles.sol#L500) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L500


 - [ ] ID-870
[OwnableRoles._ROLE_214](lib/solady/src/auth/OwnableRoles.sol#L493) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L493


 - [ ] ID-871
[OwnableRoles._ROLE_255](lib/solady/src/auth/OwnableRoles.sol#L534) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L534


 - [ ] ID-872
[OwnableRoles._ROLE_80](lib/solady/src/auth/OwnableRoles.sol#L359) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L359


 - [ ] ID-873
[OwnableRoles._ROLE_255](lib/solady/src/auth/OwnableRoles.sol#L534) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L534


 - [ ] ID-874
[OwnableRoles._ROLE_173](lib/solady/src/auth/OwnableRoles.sol#L452) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L452


 - [ ] ID-875
[OwnableRoles._ROLE_212](lib/solady/src/auth/OwnableRoles.sol#L491) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L491


 - [ ] ID-876
[OwnableRoles._ROLE_178](lib/solady/src/auth/OwnableRoles.sol#L457) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L457


 - [ ] ID-877
[OwnableRoles._ROLE_215](lib/solady/src/auth/OwnableRoles.sol#L494) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L494


 - [ ] ID-878
[OwnableRoles._ROLE_55](lib/solady/src/auth/OwnableRoles.sol#L334) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L334


 - [ ] ID-879
[OwnableRoles._ROLE_18](lib/solady/src/auth/OwnableRoles.sol#L297) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L297


 - [ ] ID-880
[OwnableRoles._ROLE_235](lib/solady/src/auth/OwnableRoles.sol#L514) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L514


 - [ ] ID-881
[OwnableRoles._ROLE_160](lib/solady/src/auth/OwnableRoles.sol#L439) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L439


 - [ ] ID-882
[OwnableRoles._ROLE_226](lib/solady/src/auth/OwnableRoles.sol#L505) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L505


 - [ ] ID-883
[OwnableRoles._ROLE_96](lib/solady/src/auth/OwnableRoles.sol#L375) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L375


 - [ ] ID-884
[OwnableRoles._ROLE_233](lib/solady/src/auth/OwnableRoles.sol#L512) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L512


 - [ ] ID-885
[OwnableRoles._ROLE_252](lib/solady/src/auth/OwnableRoles.sol#L531) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L531


 - [ ] ID-886
[OwnableRoles._ROLE_101](lib/solady/src/auth/OwnableRoles.sol#L380) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L380


 - [ ] ID-887
[OwnableRoles._ROLE_203](lib/solady/src/auth/OwnableRoles.sol#L482) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L482


 - [ ] ID-888
[OwnableRoles._ROLE_38](lib/solady/src/auth/OwnableRoles.sol#L317) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L317


 - [ ] ID-889
[OwnableRoles._ROLE_202](lib/solady/src/auth/OwnableRoles.sol#L481) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L481


 - [ ] ID-890
[OwnableRoles._ROLE_162](lib/solady/src/auth/OwnableRoles.sol#L441) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L441


 - [ ] ID-891
[OwnableRoles._ROLE_244](lib/solady/src/auth/OwnableRoles.sol#L523) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L523


 - [ ] ID-892
[OwnableRoles._ROLE_116](lib/solady/src/auth/OwnableRoles.sol#L395) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L395


 - [ ] ID-893
[OwnableRoles._ROLE_242](lib/solady/src/auth/OwnableRoles.sol#L521) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L521


 - [ ] ID-894
[OwnableRoles._ROLE_27](lib/solady/src/auth/OwnableRoles.sol#L306) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L306


 - [ ] ID-895
[OwnableRoles._ROLE_75](lib/solady/src/auth/OwnableRoles.sol#L354) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L354


 - [ ] ID-896
[OwnableRoles._ROLE_240](lib/solady/src/auth/OwnableRoles.sol#L519) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L519


 - [ ] ID-897
[OwnableRoles._ROLE_8](lib/solady/src/auth/OwnableRoles.sol#L287) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L287


 - [ ] ID-898
[OwnableRoles._ROLE_199](lib/solady/src/auth/OwnableRoles.sol#L478) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L478


 - [ ] ID-899
[OwnableRoles._ROLE_137](lib/solady/src/auth/OwnableRoles.sol#L416) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L416


 - [ ] ID-900
[OwnableRoles._ROLE_246](lib/solady/src/auth/OwnableRoles.sol#L525) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L525


 - [ ] ID-901
[OwnableRoles._ROLE_131](lib/solady/src/auth/OwnableRoles.sol#L410) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L410


 - [ ] ID-902
[OwnableRoles._ROLE_83](lib/solady/src/auth/OwnableRoles.sol#L362) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L362


 - [ ] ID-903
[OwnableRoles._ROLE_238](lib/solady/src/auth/OwnableRoles.sol#L517) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L517


 - [ ] ID-904
[OwnableRoles._ROLE_159](lib/solady/src/auth/OwnableRoles.sol#L438) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L438


 - [ ] ID-905
[OwnableRoles._ROLE_111](lib/solady/src/auth/OwnableRoles.sol#L390) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L390


 - [ ] ID-906
[OwnableRoles._ROLE_165](lib/solady/src/auth/OwnableRoles.sol#L444) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L444


 - [ ] ID-907
[OwnableRoles._ROLE_211](lib/solady/src/auth/OwnableRoles.sol#L490) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L490


 - [ ] ID-908
[OwnableRoles._ROLE_145](lib/solady/src/auth/OwnableRoles.sol#L424) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L424


 - [ ] ID-909
[OwnableRoles._ROLE_42](lib/solady/src/auth/OwnableRoles.sol#L321) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L321


 - [ ] ID-910
[OwnableRoles._ROLE_163](lib/solady/src/auth/OwnableRoles.sol#L442) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L442


 - [ ] ID-911
[OwnableRoles._ROLE_113](lib/solady/src/auth/OwnableRoles.sol#L392) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L392


 - [ ] ID-912
[OwnableRoles._ROLE_253](lib/solady/src/auth/OwnableRoles.sol#L532) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L532


 - [ ] ID-913
[OwnableRoles._ROLE_200](lib/solady/src/auth/OwnableRoles.sol#L479) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L479


 - [ ] ID-914
[OwnableRoles._ROLE_36](lib/solady/src/auth/OwnableRoles.sol#L315) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L315


 - [ ] ID-915
[OwnableRoles._ROLE_75](lib/solady/src/auth/OwnableRoles.sol#L354) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L354


 - [ ] ID-916
[OwnableRoles._ROLE_247](lib/solady/src/auth/OwnableRoles.sol#L526) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L526


 - [ ] ID-917
[OwnableRoles._ROLE_49](lib/solady/src/auth/OwnableRoles.sol#L328) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L328


 - [ ] ID-918
[OwnableRoles._ROLE_188](lib/solady/src/auth/OwnableRoles.sol#L467) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L467


 - [ ] ID-919
[OwnableRoles._ROLE_240](lib/solady/src/auth/OwnableRoles.sol#L519) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L519


 - [ ] ID-920
[OwnableRoles._ROLE_95](lib/solady/src/auth/OwnableRoles.sol#L374) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L374


 - [ ] ID-921
[OwnableRoles._ROLE_124](lib/solady/src/auth/OwnableRoles.sol#L403) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L403


 - [ ] ID-922
[OwnableRoles._ROLE_83](lib/solady/src/auth/OwnableRoles.sol#L362) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L362


 - [ ] ID-923
[OwnableRoles._ROLE_147](lib/solady/src/auth/OwnableRoles.sol#L426) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L426


 - [ ] ID-924
[OwnableRoles._ROLE_182](lib/solady/src/auth/OwnableRoles.sol#L461) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L461


 - [ ] ID-925
[OwnableRoles._ROLE_249](lib/solady/src/auth/OwnableRoles.sol#L528) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L528


 - [ ] ID-926
[OwnableRoles._ROLE_40](lib/solady/src/auth/OwnableRoles.sol#L319) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L319


 - [ ] ID-927
[OwnableRoles._ROLE_0](lib/solady/src/auth/OwnableRoles.sol#L279) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L279


 - [ ] ID-928
[OwnableRoles._ROLE_12](lib/solady/src/auth/OwnableRoles.sol#L291) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L291


 - [ ] ID-929
[OwnableRoles._ROLE_210](lib/solady/src/auth/OwnableRoles.sol#L489) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L489


 - [ ] ID-930
[OwnableRoles._ROLE_238](lib/solady/src/auth/OwnableRoles.sol#L517) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L517


 - [ ] ID-931
[OwnableRoles._ROLE_80](lib/solady/src/auth/OwnableRoles.sol#L359) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L359


 - [ ] ID-932
[OwnableRoles._ROLE_215](lib/solady/src/auth/OwnableRoles.sol#L494) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L494


 - [ ] ID-933
[OwnableRoles._ROLE_90](lib/solady/src/auth/OwnableRoles.sol#L369) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L369


 - [ ] ID-934
[OwnableRoles._ROLE_129](lib/solady/src/auth/OwnableRoles.sol#L408) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L408


 - [ ] ID-935
[OwnableRoles._ROLE_70](lib/solady/src/auth/OwnableRoles.sol#L349) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L349


 - [ ] ID-936
[OwnableRoles._ROLE_67](lib/solady/src/auth/OwnableRoles.sol#L346) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L346


 - [ ] ID-937
[OwnableRoles._ROLE_139](lib/solady/src/auth/OwnableRoles.sol#L418) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L418


 - [ ] ID-938
[OwnableRoles._ROLE_122](lib/solady/src/auth/OwnableRoles.sol#L401) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L401


 - [ ] ID-939
[OwnableRoles._ROLE_235](lib/solady/src/auth/OwnableRoles.sol#L514) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L514


 - [ ] ID-940
[OwnableRoles._ROLE_125](lib/solady/src/auth/OwnableRoles.sol#L404) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L404


 - [ ] ID-941
[OwnableRoles._ROLE_132](lib/solady/src/auth/OwnableRoles.sol#L411) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L411


 - [ ] ID-942
[OwnableRoles._ROLE_214](lib/solady/src/auth/OwnableRoles.sol#L493) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L493


 - [ ] ID-943
[OwnableRoles._ROLE_44](lib/solady/src/auth/OwnableRoles.sol#L323) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L323


 - [ ] ID-944
[OwnableRoles._ROLE_253](lib/solady/src/auth/OwnableRoles.sol#L532) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L532


 - [ ] ID-945
[OwnableRoles._ROLE_205](lib/solady/src/auth/OwnableRoles.sol#L484) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L484


 - [ ] ID-946
[OwnableRoles._ROLE_247](lib/solady/src/auth/OwnableRoles.sol#L526) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L526


 - [ ] ID-947
[OwnableRoles._ROLE_103](lib/solady/src/auth/OwnableRoles.sol#L382) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L382


 - [ ] ID-948
[OwnableRoles._ROLE_77](lib/solady/src/auth/OwnableRoles.sol#L356) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L356


 - [ ] ID-949
[OwnableRoles._ROLE_31](lib/solady/src/auth/OwnableRoles.sol#L310) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L310


 - [ ] ID-950
[OwnableRoles._ROLE_56](lib/solady/src/auth/OwnableRoles.sol#L335) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L335


 - [ ] ID-951
[OwnableRoles._ROLE_70](lib/solady/src/auth/OwnableRoles.sol#L349) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L349


 - [ ] ID-952
[OwnableRoles._ROLE_242](lib/solady/src/auth/OwnableRoles.sol#L521) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L521


 - [ ] ID-953
[OwnableRoles._ROLE_171](lib/solady/src/auth/OwnableRoles.sol#L450) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L450


 - [ ] ID-954
[OwnableRoles._ROLE_167](lib/solady/src/auth/OwnableRoles.sol#L446) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L446


 - [ ] ID-955
[OwnableRoles._ROLE_31](lib/solady/src/auth/OwnableRoles.sol#L310) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L310


 - [ ] ID-956
[OwnableRoles._ROLE_112](lib/solady/src/auth/OwnableRoles.sol#L391) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L391


 - [ ] ID-957
[OwnableRoles._ROLE_47](lib/solady/src/auth/OwnableRoles.sol#L326) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L326


 - [ ] ID-958
[OwnableRoles._ROLE_18](lib/solady/src/auth/OwnableRoles.sol#L297) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L297


 - [ ] ID-959
[OwnableRoles._ROLE_38](lib/solady/src/auth/OwnableRoles.sol#L317) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L317


 - [ ] ID-960
[OwnableRoles._ROLE_239](lib/solady/src/auth/OwnableRoles.sol#L518) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L518


 - [ ] ID-961
[OwnableRoles._ROLE_250](lib/solady/src/auth/OwnableRoles.sol#L529) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L529


 - [ ] ID-962
[OwnableRoles._ROLE_91](lib/solady/src/auth/OwnableRoles.sol#L370) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L370


 - [ ] ID-963
[OwnableRoles._ROLE_7](lib/solady/src/auth/OwnableRoles.sol#L286) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L286


 - [ ] ID-964
[OwnableRoles._ROLE_48](lib/solady/src/auth/OwnableRoles.sol#L327) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L327


 - [ ] ID-965
[OwnableRoles._ROLE_5](lib/solady/src/auth/OwnableRoles.sol#L284) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L284


 - [ ] ID-966
[OwnableRoles._ROLE_217](lib/solady/src/auth/OwnableRoles.sol#L496) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L496


 - [ ] ID-967
[OwnableRoles._ROLE_141](lib/solady/src/auth/OwnableRoles.sol#L420) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L420


 - [ ] ID-968
[OwnableRoles._ROLE_143](lib/solady/src/auth/OwnableRoles.sol#L422) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L422


 - [ ] ID-969
[OwnableRoles._ROLE_166](lib/solady/src/auth/OwnableRoles.sol#L445) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L445


 - [ ] ID-970
[OwnableRoles._ROLE_192](lib/solady/src/auth/OwnableRoles.sol#L471) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L471


 - [ ] ID-971
[OwnableRoles._ROLE_105](lib/solady/src/auth/OwnableRoles.sol#L384) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L384


 - [ ] ID-972
[OwnableRoles._ROLE_232](lib/solady/src/auth/OwnableRoles.sol#L511) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L511


 - [ ] ID-973
[OwnableRoles._ROLE_245](lib/solady/src/auth/OwnableRoles.sol#L524) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L524


 - [ ] ID-974
[OwnableRoles._ROLE_178](lib/solady/src/auth/OwnableRoles.sol#L457) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L457


 - [ ] ID-975
[OwnableRoles._ROLE_179](lib/solady/src/auth/OwnableRoles.sol#L458) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L458


 - [ ] ID-976
[OwnableRoles._ROLE_33](lib/solady/src/auth/OwnableRoles.sol#L312) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L312


 - [ ] ID-977
[OwnableRoles._ROLE_54](lib/solady/src/auth/OwnableRoles.sol#L333) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L333


 - [ ] ID-978
[OwnableRoles._ROLE_7](lib/solady/src/auth/OwnableRoles.sol#L286) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L286


 - [ ] ID-979
[OwnableRoles._ROLE_183](lib/solady/src/auth/OwnableRoles.sol#L462) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L462


 - [ ] ID-980
[OwnableRoles._ROLE_88](lib/solady/src/auth/OwnableRoles.sol#L367) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L367


 - [ ] ID-981
[OwnableRoles._ROLE_249](lib/solady/src/auth/OwnableRoles.sol#L528) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L528


 - [ ] ID-982
[OwnableRoles._ROLE_225](lib/solady/src/auth/OwnableRoles.sol#L504) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L504


 - [ ] ID-983
[OwnableRoles._ROLE_96](lib/solady/src/auth/OwnableRoles.sol#L375) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L375


 - [ ] ID-984
[OwnableRoles._ROLE_103](lib/solady/src/auth/OwnableRoles.sol#L382) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L382


 - [ ] ID-985
[OwnableRoles._ROLE_195](lib/solady/src/auth/OwnableRoles.sol#L474) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L474


 - [ ] ID-986
[OwnableRoles._ROLE_73](lib/solady/src/auth/OwnableRoles.sol#L352) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L352


 - [ ] ID-987
[OwnableRoles._ROLE_20](lib/solady/src/auth/OwnableRoles.sol#L299) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L299


 - [ ] ID-988
[OwnableRoles._ROLE_143](lib/solady/src/auth/OwnableRoles.sol#L422) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L422


 - [ ] ID-989
[OwnableRoles._ROLE_153](lib/solady/src/auth/OwnableRoles.sol#L432) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L432


 - [ ] ID-990
[OwnableRoles._ROLE_41](lib/solady/src/auth/OwnableRoles.sol#L320) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L320


 - [ ] ID-991
[OwnableRoles._ROLE_149](lib/solady/src/auth/OwnableRoles.sol#L428) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L428


 - [ ] ID-992
[OwnableRoles._ROLE_194](lib/solady/src/auth/OwnableRoles.sol#L473) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L473


 - [ ] ID-993
[OwnableRoles._ROLE_89](lib/solady/src/auth/OwnableRoles.sol#L368) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L368


 - [ ] ID-994
[OwnableRoles._ROLE_72](lib/solady/src/auth/OwnableRoles.sol#L351) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L351


 - [ ] ID-995
[OwnableRoles._ROLE_57](lib/solady/src/auth/OwnableRoles.sol#L336) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L336


 - [ ] ID-996
[OwnableRoles._ROLE_87](lib/solady/src/auth/OwnableRoles.sol#L366) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L366


 - [ ] ID-997
[OwnableRoles._ROLE_242](lib/solady/src/auth/OwnableRoles.sol#L521) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L521


 - [ ] ID-998
[OwnableRoles._ROLE_90](lib/solady/src/auth/OwnableRoles.sol#L369) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L369


 - [ ] ID-999
[OwnableRoles._ROLE_174](lib/solady/src/auth/OwnableRoles.sol#L453) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L453


 - [ ] ID-1000
[OwnableRoles._ROLE_110](lib/solady/src/auth/OwnableRoles.sol#L389) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L389


 - [ ] ID-1001
[OwnableRoles._ROLE_97](lib/solady/src/auth/OwnableRoles.sol#L376) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L376


 - [ ] ID-1002
[OwnableRoles._ROLE_193](lib/solady/src/auth/OwnableRoles.sol#L472) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L472


 - [ ] ID-1003
[OwnableRoles._ROLE_221](lib/solady/src/auth/OwnableRoles.sol#L500) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L500


 - [ ] ID-1004
[OwnableRoles._ROLE_53](lib/solady/src/auth/OwnableRoles.sol#L332) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L332


 - [ ] ID-1005
[OwnableRoles._ROLE_180](lib/solady/src/auth/OwnableRoles.sol#L459) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L459


 - [ ] ID-1006
[OwnableRoles._ROLE_107](lib/solady/src/auth/OwnableRoles.sol#L386) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L386


 - [ ] ID-1007
[OwnableRoles._ROLE_164](lib/solady/src/auth/OwnableRoles.sol#L443) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L443


 - [ ] ID-1008
[OwnableRoles._ROLE_5](lib/solady/src/auth/OwnableRoles.sol#L284) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L284


 - [ ] ID-1009
[OwnableRoles._ROLE_0](lib/solady/src/auth/OwnableRoles.sol#L279) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L279


 - [ ] ID-1010
[OwnableRoles._ROLE_102](lib/solady/src/auth/OwnableRoles.sol#L381) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L381


 - [ ] ID-1011
[OwnableRoles._ROLE_223](lib/solady/src/auth/OwnableRoles.sol#L502) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L502


 - [ ] ID-1012
[OwnableRoles._ROLE_27](lib/solady/src/auth/OwnableRoles.sol#L306) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L306


 - [ ] ID-1013
[OwnableRoles._ROLE_22](lib/solady/src/auth/OwnableRoles.sol#L301) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L301


 - [ ] ID-1014
[OwnableRoles._ROLE_57](lib/solady/src/auth/OwnableRoles.sol#L336) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L336


 - [ ] ID-1015
[OwnableRoles._ROLE_198](lib/solady/src/auth/OwnableRoles.sol#L477) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L477


 - [ ] ID-1016
[OwnableRoles._ROLE_227](lib/solady/src/auth/OwnableRoles.sol#L506) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L506


 - [ ] ID-1017
[OwnableRoles._ROLE_44](lib/solady/src/auth/OwnableRoles.sol#L323) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L323


 - [ ] ID-1018
[OwnableRoles._ROLE_191](lib/solady/src/auth/OwnableRoles.sol#L470) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L470


 - [ ] ID-1019
[OwnableRoles._ROLE_17](lib/solady/src/auth/OwnableRoles.sol#L296) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L296


 - [ ] ID-1020
[OwnableRoles._ROLE_229](lib/solady/src/auth/OwnableRoles.sol#L508) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L508


 - [ ] ID-1021
[OwnableRoles._ROLE_83](lib/solady/src/auth/OwnableRoles.sol#L362) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L362


 - [ ] ID-1022
[OwnableRoles._ROLE_204](lib/solady/src/auth/OwnableRoles.sol#L483) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L483


 - [ ] ID-1023
[OwnableRoles._ROLE_108](lib/solady/src/auth/OwnableRoles.sol#L387) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L387


 - [ ] ID-1024
[OwnableRoles._ROLE_64](lib/solady/src/auth/OwnableRoles.sol#L343) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L343


 - [ ] ID-1025
[OwnableRoles._ROLE_80](lib/solady/src/auth/OwnableRoles.sol#L359) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L359


 - [ ] ID-1026
[OwnableRoles._ROLE_81](lib/solady/src/auth/OwnableRoles.sol#L360) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L360


 - [ ] ID-1027
[OwnableRoles._ROLE_110](lib/solady/src/auth/OwnableRoles.sol#L389) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L389


 - [ ] ID-1028
[OwnableRoles._ROLE_31](lib/solady/src/auth/OwnableRoles.sol#L310) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L310


 - [ ] ID-1029
[OwnableRoles._ROLE_243](lib/solady/src/auth/OwnableRoles.sol#L522) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L522


 - [ ] ID-1030
[OwnableRoles._ROLE_104](lib/solady/src/auth/OwnableRoles.sol#L383) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L383


 - [ ] ID-1031
[OwnableRoles._ROLE_239](lib/solady/src/auth/OwnableRoles.sol#L518) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L518


 - [ ] ID-1032
[OwnableRoles._ROLE_12](lib/solady/src/auth/OwnableRoles.sol#L291) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L291


 - [ ] ID-1033
[OwnableRoles._ROLE_218](lib/solady/src/auth/OwnableRoles.sol#L497) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L497


 - [ ] ID-1034
[OwnableRoles._ROLE_150](lib/solady/src/auth/OwnableRoles.sol#L429) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L429


 - [ ] ID-1035
[OwnableRoles._ROLE_117](lib/solady/src/auth/OwnableRoles.sol#L396) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L396


 - [ ] ID-1036
[OwnableRoles._ROLE_219](lib/solady/src/auth/OwnableRoles.sol#L498) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L498


 - [ ] ID-1037
[OwnableRoles._ROLE_13](lib/solady/src/auth/OwnableRoles.sol#L292) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L292


 - [ ] ID-1038
[OwnableRoles._ROLE_40](lib/solady/src/auth/OwnableRoles.sol#L319) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L319


 - [ ] ID-1039
[OwnableRoles._ROLE_10](lib/solady/src/auth/OwnableRoles.sol#L289) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L289


 - [ ] ID-1040
[OwnableRoles._ROLE_128](lib/solady/src/auth/OwnableRoles.sol#L407) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L407


 - [ ] ID-1041
[OwnableRoles._ROLE_108](lib/solady/src/auth/OwnableRoles.sol#L387) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L387


 - [ ] ID-1042
[OwnableRoles._ROLE_228](lib/solady/src/auth/OwnableRoles.sol#L507) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L507


 - [ ] ID-1043
[OwnableRoles._ROLE_148](lib/solady/src/auth/OwnableRoles.sol#L427) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L427


 - [ ] ID-1044
[OwnableRoles._ROLE_15](lib/solady/src/auth/OwnableRoles.sol#L294) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L294


 - [ ] ID-1045
[OwnableRoles._ROLE_193](lib/solady/src/auth/OwnableRoles.sol#L472) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L472


 - [ ] ID-1046
[OwnableRoles._ROLE_113](lib/solady/src/auth/OwnableRoles.sol#L392) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L392


 - [ ] ID-1047
[OwnableRoles._ROLE_164](lib/solady/src/auth/OwnableRoles.sol#L443) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L443


 - [ ] ID-1048
[OwnableRoles._ROLE_234](lib/solady/src/auth/OwnableRoles.sol#L513) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L513


 - [ ] ID-1049
[OwnableRoles._ROLE_64](lib/solady/src/auth/OwnableRoles.sol#L343) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L343


 - [ ] ID-1050
[OwnableRoles._ROLE_100](lib/solady/src/auth/OwnableRoles.sol#L379) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L379


 - [ ] ID-1051
[OwnableRoles._ROLE_131](lib/solady/src/auth/OwnableRoles.sol#L410) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L410


 - [ ] ID-1052
[OwnableRoles._ROLE_117](lib/solady/src/auth/OwnableRoles.sol#L396) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L396


 - [ ] ID-1053
[OwnableRoles._ROLE_205](lib/solady/src/auth/OwnableRoles.sol#L484) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L484


 - [ ] ID-1054
[OwnableRoles._ROLE_94](lib/solady/src/auth/OwnableRoles.sol#L373) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L373


 - [ ] ID-1055
[OwnableRoles._ROLE_10](lib/solady/src/auth/OwnableRoles.sol#L289) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L289


 - [ ] ID-1056
[OwnableRoles._ROLE_203](lib/solady/src/auth/OwnableRoles.sol#L482) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L482


 - [ ] ID-1057
[OwnableRoles._ROLE_224](lib/solady/src/auth/OwnableRoles.sol#L503) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L503


 - [ ] ID-1058
[OwnableRoles._ROLE_208](lib/solady/src/auth/OwnableRoles.sol#L487) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L487


 - [ ] ID-1059
[OwnableRoles._ROLE_50](lib/solady/src/auth/OwnableRoles.sol#L329) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L329


 - [ ] ID-1060
[OwnableRoles._ROLE_213](lib/solady/src/auth/OwnableRoles.sol#L492) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L492


 - [ ] ID-1061
[OwnableRoles._ROLE_180](lib/solady/src/auth/OwnableRoles.sol#L459) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L459


 - [ ] ID-1062
[OwnableRoles._ROLE_22](lib/solady/src/auth/OwnableRoles.sol#L301) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L301


 - [ ] ID-1063
[OwnableRoles._ROLE_99](lib/solady/src/auth/OwnableRoles.sol#L378) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L378


 - [ ] ID-1064
[OwnableRoles._ROLE_100](lib/solady/src/auth/OwnableRoles.sol#L379) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L379


 - [ ] ID-1065
[OwnableRoles._ROLE_202](lib/solady/src/auth/OwnableRoles.sol#L481) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L481


 - [ ] ID-1066
[OwnableRoles._ROLE_61](lib/solady/src/auth/OwnableRoles.sol#L340) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L340


 - [ ] ID-1067
[OwnableRoles._ROLE_6](lib/solady/src/auth/OwnableRoles.sol#L285) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L285


 - [ ] ID-1068
[OwnableRoles._ROLE_111](lib/solady/src/auth/OwnableRoles.sol#L390) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L390


 - [ ] ID-1069
[OwnableRoles._ROLE_225](lib/solady/src/auth/OwnableRoles.sol#L504) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L504


 - [ ] ID-1070
[OwnableRoles._ROLE_222](lib/solady/src/auth/OwnableRoles.sol#L501) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L501


 - [ ] ID-1071
[OwnableRoles._ROLE_19](lib/solady/src/auth/OwnableRoles.sol#L298) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L298


 - [ ] ID-1072
[OwnableRoles._ROLE_33](lib/solady/src/auth/OwnableRoles.sol#L312) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L312


 - [ ] ID-1073
[OwnableRoles._ROLE_148](lib/solady/src/auth/OwnableRoles.sol#L427) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L427


 - [ ] ID-1074
[OwnableRoles._ROLE_59](lib/solady/src/auth/OwnableRoles.sol#L338) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L338


 - [ ] ID-1075
[OwnableRoles._ROLE_151](lib/solady/src/auth/OwnableRoles.sol#L430) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L430


 - [ ] ID-1076
[OwnableRoles._ROLE_162](lib/solady/src/auth/OwnableRoles.sol#L441) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L441


 - [ ] ID-1077
[OwnableRoles._ROLE_217](lib/solady/src/auth/OwnableRoles.sol#L496) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L496


 - [ ] ID-1078
[OwnableRoles._ROLE_230](lib/solady/src/auth/OwnableRoles.sol#L509) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L509


 - [ ] ID-1079
[OwnableRoles._ROLE_238](lib/solady/src/auth/OwnableRoles.sol#L517) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L517


 - [ ] ID-1080
[OwnableRoles._ROLE_23](lib/solady/src/auth/OwnableRoles.sol#L302) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L302


 - [ ] ID-1081
[OwnableRoles._ROLE_146](lib/solady/src/auth/OwnableRoles.sol#L425) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L425


 - [ ] ID-1082
[OwnableRoles._ROLE_76](lib/solady/src/auth/OwnableRoles.sol#L355) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L355


 - [ ] ID-1083
[OwnableRoles._ROLE_149](lib/solady/src/auth/OwnableRoles.sol#L428) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L428


 - [ ] ID-1084
[OwnableRoles._ROLE_146](lib/solady/src/auth/OwnableRoles.sol#L425) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L425


 - [ ] ID-1085
[OwnableRoles._ROLE_46](lib/solady/src/auth/OwnableRoles.sol#L325) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L325


 - [ ] ID-1086
[OwnableRoles._ROLE_125](lib/solady/src/auth/OwnableRoles.sol#L404) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L404


 - [ ] ID-1087
[OwnableRoles._ROLE_65](lib/solady/src/auth/OwnableRoles.sol#L344) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L344


 - [ ] ID-1088
[OwnableRoles._ROLE_184](lib/solady/src/auth/OwnableRoles.sol#L463) is never used in [AccountManager](contracts/account-manager/AccountManager.sol#L27-L341)

lib/solady/src/auth/OwnableRoles.sol#L463


 - [ ] ID-1089
[OwnableRoles._ROLE_93](lib/solady/src/auth/OwnableRoles.sol#L372) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L372


 - [ ] ID-1090
[OwnableRoles._ROLE_225](lib/solady/src/auth/OwnableRoles.sol#L504) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L504


 - [ ] ID-1091
[OwnableRoles._ROLE_30](lib/solady/src/auth/OwnableRoles.sol#L309) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L309


 - [ ] ID-1092
[OwnableRoles._ROLE_197](lib/solady/src/auth/OwnableRoles.sol#L476) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L476


 - [ ] ID-1093
[OwnableRoles._ROLE_200](lib/solady/src/auth/OwnableRoles.sol#L479) is never used in [CLOBManager](contracts/clob/CLOBManager.sol#L54-L341)

lib/solady/src/auth/OwnableRoles.sol#L479


 - [ ] ID-1094
[OwnableRoles._ROLE_192](lib/solady/src/auth/OwnableRoles.sol#L471) is never used in [Distributor](contracts/launchpad/Distributor.sol#L13-L198)

lib/solady/src/auth/OwnableRoles.sol#L471


