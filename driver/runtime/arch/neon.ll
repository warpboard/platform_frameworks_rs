target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:64:128-a0:0:64-n32-S64"
target triple = "armv7-none-linux-gnueabi"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;               INTRINSICS               ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

declare <2 x float> @llvm.arm.neon.vmaxs.v2f32(<2 x float>, <2 x float>) nounwind readnone
declare <4 x float> @llvm.arm.neon.vmaxs.v4f32(<4 x float>, <4 x float>) nounwind readnone
declare <2 x i32> @llvm.arm.neon.vmaxs.v2i32(<2 x i32>, <2 x i32>) nounwind readnone
declare <4 x i32> @llvm.arm.neon.vmaxs.v4i32(<4 x i32>, <4 x i32>) nounwind readnone
declare <2 x i32> @llvm.arm.neon.vmaxu.v2i32(<2 x i32>, <2 x i32>) nounwind readnone
declare <4 x i32> @llvm.arm.neon.vmaxu.v4i32(<4 x i32>, <4 x i32>) nounwind readnone
declare <4 x i16> @llvm.arm.neon.vmaxs.v4i16(<4 x i16>, <4 x i16>) nounwind readnone
declare <4 x i16> @llvm.arm.neon.vmaxu.v4i16(<4 x i16>, <4 x i16>) nounwind readnone

declare <2 x float> @llvm.arm.neon.vmins.v2f32(<2 x float>, <2 x float>) nounwind readnone
declare <4 x float> @llvm.arm.neon.vmins.v4f32(<4 x float>, <4 x float>) nounwind readnone
declare <2 x i32> @llvm.arm.neon.vmins.v2i32(<2 x i32>, <2 x i32>) nounwind readnone
declare <4 x i32> @llvm.arm.neon.vmins.v4i32(<4 x i32>, <4 x i32>) nounwind readnone
declare <2 x i32> @llvm.arm.neon.vminu.v2i32(<2 x i32>, <2 x i32>) nounwind readnone
declare <4 x i32> @llvm.arm.neon.vminu.v4i32(<4 x i32>, <4 x i32>) nounwind readnone
declare <4 x i16> @llvm.arm.neon.vmins.v4i16(<4 x i16>, <4 x i16>) nounwind readnone
declare <4 x i16> @llvm.arm.neon.vminu.v4i16(<4 x i16>, <4 x i16>) nounwind readnone

declare <8 x i8>  @llvm.arm.neon.vqshiftns.v8i8(<8 x i16>, <8 x i16>) nounwind readnone
declare <4 x i16> @llvm.arm.neon.vqshiftns.v4i16(<4 x i32>, <4 x i32>) nounwind readnone
declare <2 x i32> @llvm.arm.neon.vqshiftns.v2i32(<2 x i64>, <2 x i64>) nounwind readnone

declare <8 x i8>  @llvm.arm.neon.vqshiftnu.v8i8(<8 x i16>, <8 x i16>) nounwind readnone
declare <4 x i16> @llvm.arm.neon.vqshiftnu.v4i16(<4 x i32>, <4 x i32>) nounwind readnone
declare <2 x i32> @llvm.arm.neon.vqshiftnu.v2i32(<2 x i64>, <2 x i64>) nounwind readnone

declare <8 x i8>  @llvm.arm.neon.vqshiftnsu.v8i8(<8 x i16>, <8 x i16>) nounwind readnone
declare <4 x i16> @llvm.arm.neon.vqshiftnsu.v4i16(<4 x i32>, <4 x i32>) nounwind readnone
declare <2 x i32> @llvm.arm.neon.vqshiftnsu.v2i32(<2 x i64>, <2 x i64>) nounwind readnone

declare <2 x float> @llvm.arm.neon.vrecpe.v2f32(<2 x float>) nounwind readnone
declare <4 x float> @llvm.arm.neon.vrecpe.v4f32(<4 x float>) nounwind readnone

declare <2 x float> @llvm.arm.neon.vrsqrte.v2f32(<2 x float>) nounwind readnone
declare <4 x float> @llvm.arm.neon.vrsqrte.v4f32(<4 x float>) nounwind readnone

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;                HELPERS                 ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define internal <4 x float> @smear_4f(float %in) nounwind readnone alwaysinline {
  %1 = insertelement <4 x float> undef, float %in, i32 0
  %2 = insertelement <4 x float> %1, float %in, i32 1
  %3 = insertelement <4 x float> %2, float %in, i32 2
  %4 = insertelement <4 x float> %3, float %in, i32 3
  ret <4 x float> %4
}

define internal <4 x i32> @smear_4i(i32 %in) nounwind readnone alwaysinline {
  %1 = insertelement <4 x i32> undef, i32 %in, i32 0
  %2 = insertelement <4 x i32> %1, i32 %in, i32 1
  %3 = insertelement <4 x i32> %2, i32 %in, i32 2
  %4 = insertelement <4 x i32> %3, i32 %in, i32 3
  ret <4 x i32> %4
}

define internal <4 x i16> @smear_4s(i16 %in) nounwind readnone alwaysinline {
  %1 = insertelement <4 x i16> undef, i16 %in, i32 0
  %2 = insertelement <4 x i16> %1, i16 %in, i32 1
  %3 = insertelement <4 x i16> %2, i16 %in, i32 2
  %4 = insertelement <4 x i16> %3, i16 %in, i32 3
  ret <4 x i16> %4
}



define internal <2 x float> @smear_2f(float %in) nounwind readnone alwaysinline {
  %1 = insertelement <2 x float> undef, float %in, i32 0
  %2 = insertelement <2 x float> %1, float %in, i32 1
  ret <2 x float> %2
}

define internal <2 x i32> @smear_2i(i32 %in) nounwind readnone alwaysinline {
  %1 = insertelement <2 x i32> undef, i32 %in, i32 0
  %2 = insertelement <2 x i32> %1, i32 %in, i32 1
  ret <2 x i32> %2
}

define internal <2 x i16> @smear_2s(i16 %in) nounwind readnone alwaysinline {
  %1 = insertelement <2 x i16> undef, i16 %in, i32 0
  %2 = insertelement <2 x i16> %1, i16 %in, i32 1
  ret <2 x i16> %2
}


define internal <4 x i32> @smear_4i32(i32 %in) nounwind readnone alwaysinline {
  %1 = insertelement <4 x i32> undef, i32 %in, i32 0
  %2 = insertelement <4 x i32> %1, i32 %in, i32 1
  %3 = insertelement <4 x i32> %2, i32 %in, i32 2
  %4 = insertelement <4 x i32> %3, i32 %in, i32 3
  ret <4 x i32> %4
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;                 CLAMP                  ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define <4 x float> @_Z5clampDv4_fS_S_(<4 x float> %value, <4 x float> %low, <4 x float> %high) nounwind readonly {
  %1 = tail call <4 x float> @llvm.arm.neon.vmins.v4f32(<4 x float> %value, <4 x float> %high) nounwind readnone
  %2 = tail call <4 x float> @llvm.arm.neon.vmaxs.v4f32(<4 x float> %1, <4 x float> %low) nounwind readnone
  ret <4 x float> %2
}

define <4 x float> @_Z5clampDv4_fff(<4 x float> %value, float %low, float %high) nounwind readonly {
  %_high = tail call <4 x float> @smear_4f(float %high) nounwind readnone
  %_low = tail call <4 x float> @smear_4f(float %low) nounwind readnone
  %out = tail call <4 x float> @_Z5clampDv4_fS_S_(<4 x float> %value, <4 x float> %_low, <4 x float> %_high) nounwind readonly
  ret <4 x float> %out
}

define <3 x float> @_Z5clampDv3_fS_S_(<3 x float> %value, <3 x float> %low, <3 x float> %high) nounwind readonly {
  %_value = shufflevector <3 x float> %value, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %_low = shufflevector <3 x float> %low, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %_high = shufflevector <3 x float> %high, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %a = tail call <4 x float> @llvm.arm.neon.vmins.v4f32(<4 x float> %_value, <4 x float> %_high) nounwind readnone
  %b = tail call <4 x float> @llvm.arm.neon.vmaxs.v4f32(<4 x float> %a, <4 x float> %_low) nounwind readnone
  %c = shufflevector <4 x float> %b, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x float> %c
}

define <3 x float> @_Z5clampDv3_fff(<3 x float> %value, float %low, float %high) nounwind readonly {
  %_value = shufflevector <3 x float> %value, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %_high = tail call <4 x float> @smear_4f(float %high) nounwind readnone
  %_low = tail call <4 x float> @smear_4f(float %low) nounwind readnone
  %a = tail call <4 x float> @llvm.arm.neon.vmins.v4f32(<4 x float> %_value, <4 x float> %_high) nounwind readnone
  %b = tail call <4 x float> @llvm.arm.neon.vmaxs.v4f32(<4 x float> %a, <4 x float> %_low) nounwind readnone
  %c = shufflevector <4 x float> %b, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x float> %c
}

define <2 x float> @_Z5clampDv2_fS_S_(<2 x float> %value, <2 x float> %low, <2 x float> %high) nounwind readonly {
  %1 = tail call <2 x float> @llvm.arm.neon.vmins.v2f32(<2 x float> %value, <2 x float> %high) nounwind readnone
  %2 = tail call <2 x float> @llvm.arm.neon.vmaxs.v2f32(<2 x float> %1, <2 x float> %low) nounwind readnone
  ret <2 x float> %2
}

define <2 x float> @_Z5clampDv2_fff(<2 x float> %value, float %low, float %high) nounwind readonly {
  %_high = tail call <2 x float> @smear_2f(float %high) nounwind readnone
  %_low = tail call <2 x float> @smear_2f(float %low) nounwind readnone
  %a = tail call <2 x float> @llvm.arm.neon.vmins.v2f32(<2 x float> %value, <2 x float> %_high) nounwind readnone
  %b = tail call <2 x float> @llvm.arm.neon.vmaxs.v2f32(<2 x float> %a, <2 x float> %_low) nounwind readnone
  ret <2 x float> %b
}

define float @_Z5clampfff(float %value, float %low, float %high) nounwind readonly {
  %1 = fcmp olt float %value, %high
  %2 = select i1 %1, float %value, float %high
  %3 = fcmp ogt float %2, %low
  %4 = select i1 %3, float %2, float %low
  ret float %4
}



define <4 x i32> @_Z5clampDv4_iS_S_(<4 x i32> %value, <4 x i32> %low, <4 x i32> %high) nounwind readonly {
  %1 = tail call <4 x i32> @llvm.arm.neon.vmins.v4i32(<4 x i32> %value, <4 x i32> %high) nounwind readnone
  %2 = tail call <4 x i32> @llvm.arm.neon.vmaxs.v4i32(<4 x i32> %1, <4 x i32> %low) nounwind readnone
  ret <4 x i32> %2
}

define <4 x i32> @_Z5clampDv4_iii(<4 x i32> %value, i32 %low, i32 %high) nounwind readonly {
  %_high = tail call <4 x i32> @smear_4i(i32 %high) nounwind readnone
  %_low = tail call <4 x i32> @smear_4i(i32 %low) nounwind readnone
  %1 = tail call <4 x i32> @llvm.arm.neon.vmins.v4i32(<4 x i32> %value, <4 x i32> %_high) nounwind readnone
  %2 = tail call <4 x i32> @llvm.arm.neon.vmaxs.v4i32(<4 x i32> %1, <4 x i32> %_low) nounwind readnone
  ret <4 x i32> %2
}

define <3 x i32> @_Z5clampDv3_iS_S_(<3 x i32> %value, <3 x i32> %low, <3 x i32> %high) nounwind readonly {
  %_value = shufflevector <3 x i32> %value, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %_low = shufflevector <3 x i32> %low, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %_high = shufflevector <3 x i32> %high, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %a = tail call <4 x i32> @llvm.arm.neon.vmins.v4i32(<4 x i32> %_value, <4 x i32> %_high) nounwind readnone
  %b = tail call <4 x i32> @llvm.arm.neon.vmaxs.v4i32(<4 x i32> %a, <4 x i32> %_low) nounwind readnone
  %c = shufflevector <4 x i32> %b, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x i32> %c
}

define <3 x i32> @_Z5clampDv3_iii(<3 x i32> %value, i32 %low, i32 %high) nounwind readonly {
  %_value = shufflevector <3 x i32> %value, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %_high = tail call <4 x i32> @smear_4i(i32 %high) nounwind readnone
  %_low = tail call <4 x i32> @smear_4i(i32 %low) nounwind readnone
  %a = tail call <4 x i32> @llvm.arm.neon.vmins.v4i32(<4 x i32> %_value, <4 x i32> %_high) nounwind readnone
  %b = tail call <4 x i32> @llvm.arm.neon.vmaxs.v4i32(<4 x i32> %a, <4 x i32> %_low) nounwind readnone
  %c = shufflevector <4 x i32> %b, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x i32> %c
}

define <2 x i32> @_Z5clampDv2_iS_S_(<2 x i32> %value, <2 x i32> %low, <2 x i32> %high) nounwind readonly {
  %1 = tail call <2 x i32> @llvm.arm.neon.vmins.v2i32(<2 x i32> %value, <2 x i32> %high) nounwind readnone
  %2 = tail call <2 x i32> @llvm.arm.neon.vmaxs.v2i32(<2 x i32> %1, <2 x i32> %low) nounwind readnone
  ret <2 x i32> %2
}

define <2 x i32> @_Z5clampDv2_iii(<2 x i32> %value, i32 %low, i32 %high) nounwind readonly {
  %_high = tail call <2 x i32> @smear_2i(i32 %high) nounwind readnone
  %_low = tail call <2 x i32> @smear_2i(i32 %low) nounwind readnone
  %a = tail call <2 x i32> @llvm.arm.neon.vmins.v2i32(<2 x i32> %value, <2 x i32> %_high) nounwind readnone
  %b = tail call <2 x i32> @llvm.arm.neon.vmaxs.v2i32(<2 x i32> %a, <2 x i32> %_low) nounwind readnone
  ret <2 x i32> %b
}



define <4 x i32> @_Z5clampDv4_jS_S_(<4 x i32> %value, <4 x i32> %low, <4 x i32> %high) nounwind readonly {
  %1 = tail call <4 x i32> @llvm.arm.neon.vminu.v4i32(<4 x i32> %value, <4 x i32> %high) nounwind readnone
  %2 = tail call <4 x i32> @llvm.arm.neon.vmaxu.v4i32(<4 x i32> %1, <4 x i32> %low) nounwind readnone
  ret <4 x i32> %2
}

define <4 x i32> @_Z5clampDv4_jjj(<4 x i32> %value, i32 %low, i32 %high) nounwind readonly {
  %_high = tail call <4 x i32> @smear_4i(i32 %high) nounwind readnone
  %_low = tail call <4 x i32> @smear_4i(i32 %low) nounwind readnone
  %1 = tail call <4 x i32> @llvm.arm.neon.vminu.v4i32(<4 x i32> %value, <4 x i32> %_high) nounwind readnone
  %2 = tail call <4 x i32> @llvm.arm.neon.vmaxu.v4i32(<4 x i32> %1, <4 x i32> %_low) nounwind readnone
  ret <4 x i32> %2
}

define <3 x i32> @_Z5clampDv3_jS_S_(<3 x i32> %value, <3 x i32> %low, <3 x i32> %high) nounwind readonly {
  %_value = shufflevector <3 x i32> %value, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %_low = shufflevector <3 x i32> %low, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %_high = shufflevector <3 x i32> %high, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %a = tail call <4 x i32> @llvm.arm.neon.vminu.v4i32(<4 x i32> %_value, <4 x i32> %_high) nounwind readnone
  %b = tail call <4 x i32> @llvm.arm.neon.vmaxu.v4i32(<4 x i32> %a, <4 x i32> %_low) nounwind readnone
  %c = shufflevector <4 x i32> %b, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x i32> %c
}

define <3 x i32> @_Z5clampDv3_jjj(<3 x i32> %value, i32 %low, i32 %high) nounwind readonly {
  %_value = shufflevector <3 x i32> %value, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %_high = tail call <4 x i32> @smear_4i(i32 %high) nounwind readnone
  %_low = tail call <4 x i32> @smear_4i(i32 %low) nounwind readnone
  %a = tail call <4 x i32> @llvm.arm.neon.vminu.v4i32(<4 x i32> %_value, <4 x i32> %_high) nounwind readnone
  %b = tail call <4 x i32> @llvm.arm.neon.vmaxu.v4i32(<4 x i32> %a, <4 x i32> %_low) nounwind readnone
  %c = shufflevector <4 x i32> %b, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x i32> %c
}

define <2 x i32> @_Z5clampDv2_jS_S_(<2 x i32> %value, <2 x i32> %low, <2 x i32> %high) nounwind readonly {
  %1 = tail call <2 x i32> @llvm.arm.neon.vminu.v2i32(<2 x i32> %value, <2 x i32> %high) nounwind readnone
  %2 = tail call <2 x i32> @llvm.arm.neon.vmaxu.v2i32(<2 x i32> %1, <2 x i32> %low) nounwind readnone
  ret <2 x i32> %2
}

define <2 x i32> @_Z5clampDv2_jjj(<2 x i32> %value, i32 %low, i32 %high) nounwind readonly {
  %_high = tail call <2 x i32> @smear_2i(i32 %high) nounwind readnone
  %_low = tail call <2 x i32> @smear_2i(i32 %low) nounwind readnone
  %a = tail call <2 x i32> @llvm.arm.neon.vminu.v2i32(<2 x i32> %value, <2 x i32> %_high) nounwind readnone
  %b = tail call <2 x i32> @llvm.arm.neon.vmaxu.v2i32(<2 x i32> %a, <2 x i32> %_low) nounwind readnone
  ret <2 x i32> %b
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;                  FMAX                  ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define <4 x float> @_Z4fmaxDv4_fS_(<4 x float> %v1, <4 x float> %v2) nounwind readonly {
  %1 = tail call <4 x float> @llvm.arm.neon.vmaxs.v4f32(<4 x float> %v1, <4 x float> %v2) nounwind readnone
  ret <4 x float> %1
}

define <4 x float> @_Z4fmaxDv4_ff(<4 x float> %v1, float %v2) nounwind readonly {
  %1 = tail call <4 x float> @smear_4f(float %v2) nounwind readnone
  %2 = tail call <4 x float> @llvm.arm.neon.vmaxs.v4f32(<4 x float> %v1, <4 x float> %1) nounwind readnone
  ret <4 x float> %2
}

define <3 x float> @_Z4fmaxDv3_fS_(<3 x float> %v1, <3 x float> %v2) nounwind readonly {
  %1 = shufflevector <3 x float> %v1, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = shufflevector <3 x float> %v2, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %3 = tail call <4 x float> @llvm.arm.neon.vmaxs.v4f32(<4 x float> %1, <4 x float> %2) nounwind readnone
  %4 = shufflevector <4 x float> %3, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x float> %4
}

define <3 x float> @_Z4fmaxDv3_ff(<3 x float> %v1, float %v2) nounwind readonly {
  %1 = shufflevector <3 x float> %v1, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = tail call <4 x float> @smear_4f(float %v2) nounwind readnone
  %3 = tail call <4 x float> @llvm.arm.neon.vmaxs.v4f32(<4 x float> %1, <4 x float> %2) nounwind readnone
  %c = shufflevector <4 x float> %3, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x float> %c
}

define <2 x float> @_Z4fmaxDv2_fS_(<2 x float> %v1, <2 x float> %v2) nounwind readonly {
  %1 = tail call <2 x float> @llvm.arm.neon.vmaxs.v2f32(<2 x float> %v1, <2 x float> %v2) nounwind readnone
  ret <2 x float> %1
}

define <2 x float> @_Z4fmaxDv2_ff(<2 x float> %v1, float %v2) nounwind readonly {
  %1 = tail call <2 x float> @smear_2f(float %v2) nounwind readnone
  %2 = tail call <2 x float> @llvm.arm.neon.vmaxs.v2f32(<2 x float> %v1, <2 x float> %1) nounwind readnone
  ret <2 x float> %2
}

define float @_Z4fmaxff(float %v1, float %v2) nounwind readonly {
  %1 = fcmp ogt float %v1, %v2
  %2 = select i1 %1, float %v1, float %v2
  ret float %2
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;                  FMIN                  ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define <4 x float> @_Z4fminDv4_fS_(<4 x float> %v1, <4 x float> %v2) nounwind readonly {
  %1 = tail call <4 x float> @llvm.arm.neon.vmins.v4f32(<4 x float> %v1, <4 x float> %v2) nounwind readnone
  ret <4 x float> %1
}

define <4 x float> @_Z4fminDv4_ff(<4 x float> %v1, float %v2) nounwind readonly {
  %1 = tail call <4 x float> @smear_4f(float %v2) nounwind readnone
  %2 = tail call <4 x float> @llvm.arm.neon.vmins.v4f32(<4 x float> %v1, <4 x float> %1) nounwind readnone
  ret <4 x float> %2
}

define <3 x float> @_Z4fminDv3_fS_(<3 x float> %v1, <3 x float> %v2) nounwind readonly {
  %1 = shufflevector <3 x float> %v1, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = shufflevector <3 x float> %v2, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %3 = tail call <4 x float> @llvm.arm.neon.vmins.v4f32(<4 x float> %1, <4 x float> %2) nounwind readnone
  %4 = shufflevector <4 x float> %3, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x float> %4
}

define <3 x float> @_Z4fminDv3_ff(<3 x float> %v1, float %v2) nounwind readonly {
  %1 = shufflevector <3 x float> %v1, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = tail call <4 x float> @smear_4f(float %v2) nounwind readnone
  %3 = tail call <4 x float> @llvm.arm.neon.vmins.v4f32(<4 x float> %1, <4 x float> %2) nounwind readnone
  %c = shufflevector <4 x float> %3, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x float> %c
}

define <2 x float> @_Z4fminDv2_fS_(<2 x float> %v1, <2 x float> %v2) nounwind readonly {
  %1 = tail call <2 x float> @llvm.arm.neon.vmins.v2f32(<2 x float> %v1, <2 x float> %v2) nounwind readnone
  ret <2 x float> %1
}

define <2 x float> @_Z4fminDv2_ff(<2 x float> %v1, float %v2) nounwind readonly {
  %1 = tail call <2 x float> @smear_2f(float %v2) nounwind readnone
  %2 = tail call <2 x float> @llvm.arm.neon.vmins.v2f32(<2 x float> %v1, <2 x float> %1) nounwind readnone
  ret <2 x float> %2
}

define float @_Z4fminff(float %v1, float %v2) nounwind readnone {
  %1 = fcmp olt float %v1, %v2
  %2 = select i1 %1, float %v1, float %v2
  ret float %2
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;                  MAX                   ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define signext i8 @_Z3maxcc(i8 signext %v1, i8 signext %v2) nounwind readnone {
  %1 = icmp sgt i8 %v1, %v2
  %2 = select i1 %1, i8 %v1, i8 %v2
  ret i8 %2
}

define <2 x i8> @_Z3maxDv2_cS_(<2 x i8> %v1, <2 x i8> %v2) nounwind readnone {
  %1 = sext <2 x i8> %v1 to <2 x i32>
  %2 = sext <2 x i8> %v2 to <2 x i32>
  %3 = tail call <2 x i32> @llvm.arm.neon.vmaxs.v2i32(<2 x i32> %1, <2 x i32> %2) nounwind readnone
  %4 = trunc <2 x i32> %3 to <2 x i8>
  ret <2 x i8> %4
}

define <3 x i8> @_Z3maxDv3_cS_(<3 x i8> %v1, <3 x i8> %v2) nounwind readnone {
  %1 = sext <3 x i8> %v1 to <3 x i32>
  %2 = sext <3 x i8> %v2 to <3 x i32>
  %3 = shufflevector <3 x i32> %1, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %4 = shufflevector <3 x i32> %2, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %5 = tail call <4 x i32> @llvm.arm.neon.vmaxs.v4i32(<4 x i32> %3, <4 x i32> %4) nounwind readnone
  %6 = shufflevector <4 x i32> %5, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %7 = trunc <3 x i32> %6 to <3 x i8>
  ret <3 x i8> %7
}

define <4 x i8> @_Z3maxDv4_cS_(<4 x i8> %v1, <4 x i8> %v2) nounwind readnone {
  %1 = sext <4 x i8> %v1 to <4 x i32>
  %2 = sext <4 x i8> %v2 to <4 x i32>
  %3 = tail call <4 x i32> @llvm.arm.neon.vmaxs.v4i32(<4 x i32> %1, <4 x i32> %2) nounwind readnone
  %4 = trunc <4 x i32> %3 to <4 x i8>
  ret <4 x i8> %4
}

define signext i16 @_Z3maxss(i16 signext %v1, i16 signext %v2) nounwind readnone {
  %1 = icmp sgt i16 %v1, %v2
  %2 = select i1 %1, i16 %v1, i16 %v2
  ret i16 %2
}

define <2 x i16> @_Z3maxDv2_sS_(<2 x i16> %v1, <2 x i16> %v2) nounwind readnone {
  %1 = sext <2 x i16> %v1 to <2 x i32>
  %2 = sext <2 x i16> %v2 to <2 x i32>
  %3 = tail call <2 x i32> @llvm.arm.neon.vmaxs.v2i32(<2 x i32> %1, <2 x i32> %2) nounwind readnone
  %4 = trunc <2 x i32> %3 to <2 x i16>
  ret <2 x i16> %4
}

define <3 x i16> @_Z3maxDv3_sS_(<3 x i16> %v1, <3 x i16> %v2) nounwind readnone {
  %1 = sext <3 x i16> %v1 to <3 x i32>
  %2 = sext <3 x i16> %v2 to <3 x i32>
  %3 = shufflevector <3 x i32> %1, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %4 = shufflevector <3 x i32> %2, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %5 = tail call <4 x i32> @llvm.arm.neon.vmaxs.v4i32(<4 x i32> %3, <4 x i32> %4) nounwind readnone
  %6 = shufflevector <4 x i32> %5, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %7 = trunc <3 x i32> %6 to <3 x i16>
  ret <3 x i16> %7
}

define <4 x i16> @_Z3maxDv4_sS_(<4 x i16> %v1, <4 x i16> %v2) nounwind readnone {
  %1 = sext <4 x i16> %v1 to <4 x i32>
  %2 = sext <4 x i16> %v2 to <4 x i32>
  %3 = tail call <4 x i32> @llvm.arm.neon.vmaxs.v4i32(<4 x i32> %1, <4 x i32> %2) nounwind readnone
  %4 = trunc <4 x i32> %3 to <4 x i16>
  ret <4 x i16> %4
}

define i32 @_Z3maxii(i32 %v1, i32 %v2) nounwind readnone {
  %1 = icmp sgt i32 %v1, %v2
  %2 = select i1 %1, i32 %v1, i32 %v2
  ret i32 %2
}

define <2 x i32> @_Z3maxDv2_iS_(<2 x i32> %v1, <2 x i32> %v2) nounwind readnone {
  %1 = tail call <2 x i32> @llvm.arm.neon.vmaxs.v2i32(<2 x i32> %v1, <2 x i32> %v2) nounwind readnone
  ret <2 x i32> %1
}

define <3 x i32> @_Z3maxDv3_iS_(<3 x i32> %v1, <3 x i32> %v2) nounwind readnone {
  %1 = shufflevector <3 x i32> %v1, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = shufflevector <3 x i32> %v2, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %3 = tail call <4 x i32   > @llvm.arm.neon.vmaxs.v4i32(<4 x i32> %1, <4 x i32> %2) nounwind readnone
  %4 = shufflevector <4 x i32> %3, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x i32> %4
}

define <4 x i32> @_Z3maxDv4_iS_(<4 x i32> %v1, <4 x i32> %v2) nounwind readnone {
  %1 = tail call <4 x i32> @llvm.arm.neon.vmaxs.v4i32(<4 x i32> %v1, <4 x i32> %v2) nounwind readnone
  ret <4 x i32> %1
}

define i64 @_Z3maxxx(i64 %v1, i64 %v2) nounwind readnone {
  %1 = icmp sgt i64 %v1, %v2
  %2 = select i1 %1, i64 %v1, i64 %v2
  ret i64 %2
}

; TODO:  long vector types

define zeroext i8 @_Z3maxhh(i8 zeroext %v1, i8 zeroext %v2) nounwind readnone {
  %1 = icmp ugt i8 %v1, %v2
  %2 = select i1 %1, i8 %v1, i8 %v2
  ret i8 %2
}

define <2 x i8> @_Z3maxDv2_hS_(<2 x i8> %v1, <2 x i8> %v2) nounwind readnone {
  %1 = zext <2 x i8> %v1 to <2 x i32>
  %2 = zext <2 x i8> %v2 to <2 x i32>
  %3 = tail call <2 x i32> @llvm.arm.neon.vmaxu.v2i32(<2 x i32> %1, <2 x i32> %2) nounwind readnone
  %4 = trunc <2 x i32> %3 to <2 x i8>
  ret <2 x i8> %4
}

define <3 x i8> @_Z3maxDv3_hS_(<3 x i8> %v1, <3 x i8> %v2) nounwind readnone {
  %1 = zext <3 x i8> %v1 to <3 x i32>
  %2 = zext <3 x i8> %v2 to <3 x i32>
  %3 = shufflevector <3 x i32> %1, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %4 = shufflevector <3 x i32> %2, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %5 = tail call <4 x i32> @llvm.arm.neon.vmaxu.v4i32(<4 x i32> %3, <4 x i32> %4) nounwind readnone
  %6 = shufflevector <4 x i32> %5, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %7 = trunc <3 x i32> %6 to <3 x i8>
  ret <3 x i8> %7
}

define <4 x i8> @_Z3maxDv4_hS_(<4 x i8> %v1, <4 x i8> %v2) nounwind readnone {
  %1 = zext <4 x i8> %v1 to <4 x i32>
  %2 = zext <4 x i8> %v2 to <4 x i32>
  %3 = tail call <4 x i32> @llvm.arm.neon.vmaxu.v4i32(<4 x i32> %1, <4 x i32> %2) nounwind readnone
  %4 = trunc <4 x i32> %3 to <4 x i8>
  ret <4 x i8> %4
}

define zeroext i16 @_Z3maxtt(i16 zeroext %v1, i16 zeroext %v2) nounwind readnone {
  %1 = icmp ugt i16 %v1, %v2
  %2 = select i1 %1, i16 %v1, i16 %v2
  ret i16 %2
}

define <2 x i16> @_Z3maxDv2_tS_(<2 x i16> %v1, <2 x i16> %v2) nounwind readnone {
  %1 = zext <2 x i16> %v1 to <2 x i32>
  %2 = zext <2 x i16> %v2 to <2 x i32>
  %3 = tail call <2 x i32> @llvm.arm.neon.vmaxu.v2i32(<2 x i32> %1, <2 x i32> %2) nounwind readnone
  %4 = trunc <2 x i32> %3 to <2 x i16>
  ret <2 x i16> %4
}

define <3 x i16> @_Z3maxDv3_tS_(<3 x i16> %v1, <3 x i16> %v2) nounwind readnone {
  %1 = zext <3 x i16> %v1 to <3 x i32>
  %2 = zext <3 x i16> %v2 to <3 x i32>
  %3 = shufflevector <3 x i32> %1, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %4 = shufflevector <3 x i32> %2, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %5 = tail call <4 x i32> @llvm.arm.neon.vmaxu.v4i32(<4 x i32> %3, <4 x i32> %4) nounwind readnone
  %6 = shufflevector <4 x i32> %5, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %7 = trunc <3 x i32> %6 to <3 x i16>
  ret <3 x i16> %7
}

define <4 x i16> @_Z3maxDv4_tS_(<4 x i16> %v1, <4 x i16> %v2) nounwind readnone {
  %1 = zext <4 x i16> %v1 to <4 x i32>
  %2 = zext <4 x i16> %v2 to <4 x i32>
  %3 = tail call <4 x i32> @llvm.arm.neon.vmaxu.v4i32(<4 x i32> %1, <4 x i32> %2) nounwind readnone
  %4 = trunc <4 x i32> %3 to <4 x i16>
  ret <4 x i16> %4
}

define i32 @_Z3maxjj(i32 %v1, i32 %v2) nounwind readnone {
  %1 = icmp ugt i32 %v1, %v2
  %2 = select i1 %1, i32 %v1, i32 %v2
  ret i32 %2
}

define <2 x i32> @_Z3maxDv2_jS_(<2 x i32> %v1, <2 x i32> %v2) nounwind readnone {
  %1 = tail call <2 x i32> @llvm.arm.neon.vmaxu.v2i32(<2 x i32> %v1, <2 x i32> %v2) nounwind readnone
  ret <2 x i32> %1
}

define <3 x i32> @_Z3maxDv3_jS_(<3 x i32> %v1, <3 x i32> %v2) nounwind readnone {
  %1 = shufflevector <3 x i32> %v1, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = shufflevector <3 x i32> %v2, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %3 = tail call <4 x i32   > @llvm.arm.neon.vmaxu.v4i32(<4 x i32> %1, <4 x i32> %2) nounwind readnone
  %4 = shufflevector <4 x i32> %3, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x i32> %4
}

define <4 x i32> @_Z3maxDv4_jS_(<4 x i32> %v1, <4 x i32> %v2) nounwind readnone {
  %1 = tail call <4 x i32> @llvm.arm.neon.vmaxu.v4i32(<4 x i32> %v1, <4 x i32> %v2) nounwind readnone
  ret <4 x i32> %1
}

define i64 @_Z3maxyy(i64 %v1, i64 %v2) nounwind readnone {
  %1 = icmp ugt i64 %v1, %v2
  %2 = select i1 %1, i64 %v1, i64 %v2
  ret i64 %2
}

; TODO:  long vector types

define float @_Z3maxff(float %v1, float %v2) nounwind readnone {
  %1 = tail call float @_Z4fmaxff(float %v1, float %v2)
  ret float %1
}

define <2 x float> @_Z3maxDv2_fS_(<2 x float> %v1, <2 x float> %v2) nounwind readnone {
  %1 = tail call <2 x float> @_Z4fmaxDv2_fS_(<2 x float> %v1, <2 x float> %v2)
  ret <2 x float> %1
}

define <2 x float> @_Z3maxDv2_ff(<2 x float> %v1, float %v2) nounwind readnone {
  %1 = tail call <2 x float> @_Z4fmaxDv2_ff(<2 x float> %v1, float %v2)
  ret <2 x float> %1
}

define <3 x float> @_Z3maxDv3_fS_(<3 x float> %v1, <3 x float> %v2) nounwind readnone {
  %1 = tail call <3 x float> @_Z4fmaxDv3_fS_(<3 x float> %v1, <3 x float> %v2)
  ret <3 x float> %1
}

define <3 x float> @_Z3maxDv3_ff(<3 x float> %v1, float %v2) nounwind readnone {
  %1 = tail call <3 x float> @_Z4fmaxDv3_ff(<3 x float> %v1, float %v2)
  ret <3 x float> %1
}

define <4 x float> @_Z3maxDv4_fS_(<4 x float> %v1, <4 x float> %v2) nounwind readnone {
  %1 = tail call <4 x float> @_Z4fmaxDv4_fS_(<4 x float> %v1, <4 x float> %v2)
  ret <4 x float> %1
}

define <4 x float> @_Z3maxDv4_ff(<4 x float> %v1, float %v2) nounwind readnone {
  %1 = tail call <4 x float> @_Z4fmaxDv4_ff(<4 x float> %v1, float %v2)
  ret <4 x float> %1
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;                  MIN                   ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define signext i8 @_Z3mincc(i8 signext %v1, i8 signext %v2) nounwind readnone {
  %1 = icmp slt i8 %v1, %v2
  %2 = select i1 %1, i8 %v1, i8 %v2
  ret i8 %2
}

define <2 x i8> @_Z3minDv2_cS_(<2 x i8> %v1, <2 x i8> %v2) nounwind readnone {
  %1 = sext <2 x i8> %v1 to <2 x i32>
  %2 = sext <2 x i8> %v2 to <2 x i32>
  %3 = tail call <2 x i32> @llvm.arm.neon.vmins.v2i32(<2 x i32> %1, <2 x i32> %2) nounwind readnone
  %4 = trunc <2 x i32> %3 to <2 x i8>
  ret <2 x i8> %4
}

define <3 x i8> @_Z3minDv3_cS_(<3 x i8> %v1, <3 x i8> %v2) nounwind readnone {
  %1 = sext <3 x i8> %v1 to <3 x i32>
  %2 = sext <3 x i8> %v2 to <3 x i32>
  %3 = shufflevector <3 x i32> %1, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %4 = shufflevector <3 x i32> %2, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %5 = tail call <4 x i32> @llvm.arm.neon.vmins.v4i32(<4 x i32> %3, <4 x i32> %4) nounwind readnone
  %6 = shufflevector <4 x i32> %5, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %7 = trunc <3 x i32> %6 to <3 x i8>
  ret <3 x i8> %7
}

define <4 x i8> @_Z3minDv4_cS_(<4 x i8> %v1, <4 x i8> %v2) nounwind readnone {
  %1 = sext <4 x i8> %v1 to <4 x i32>
  %2 = sext <4 x i8> %v2 to <4 x i32>
  %3 = tail call <4 x i32> @llvm.arm.neon.vmins.v4i32(<4 x i32> %1, <4 x i32> %2) nounwind readnone
  %4 = trunc <4 x i32> %3 to <4 x i8>
  ret <4 x i8> %4
}

define signext i16 @_Z3minss(i16 signext %v1, i16 signext %v2) nounwind readnone {
  %1 = icmp slt i16 %v1, %v2
  %2 = select i1 %1, i16 %v1, i16 %v2
  ret i16 %2
}

define <2 x i16> @_Z3minDv2_sS_(<2 x i16> %v1, <2 x i16> %v2) nounwind readnone {
  %1 = sext <2 x i16> %v1 to <2 x i32>
  %2 = sext <2 x i16> %v2 to <2 x i32>
  %3 = tail call <2 x i32> @llvm.arm.neon.vmins.v2i32(<2 x i32> %1, <2 x i32> %2) nounwind readnone
  %4 = trunc <2 x i32> %3 to <2 x i16>
  ret <2 x i16> %4
}

define <3 x i16> @_Z3minDv3_sS_(<3 x i16> %v1, <3 x i16> %v2) nounwind readnone {
  %1 = sext <3 x i16> %v1 to <3 x i32>
  %2 = sext <3 x i16> %v2 to <3 x i32>
  %3 = shufflevector <3 x i32> %1, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %4 = shufflevector <3 x i32> %2, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %5 = tail call <4 x i32> @llvm.arm.neon.vmins.v4i32(<4 x i32> %3, <4 x i32> %4) nounwind readnone
  %6 = shufflevector <4 x i32> %5, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %7 = trunc <3 x i32> %6 to <3 x i16>
  ret <3 x i16> %7
}

define <4 x i16> @_Z3minDv4_sS_(<4 x i16> %v1, <4 x i16> %v2) nounwind readnone {
  %1 = sext <4 x i16> %v1 to <4 x i32>
  %2 = sext <4 x i16> %v2 to <4 x i32>
  %3 = tail call <4 x i32> @llvm.arm.neon.vmins.v4i32(<4 x i32> %1, <4 x i32> %2) nounwind readnone
  %4 = trunc <4 x i32> %3 to <4 x i16>
  ret <4 x i16> %4
}

define i32 @_Z3minii(i32 %v1, i32 %v2) nounwind readnone {
  %1 = icmp slt i32 %v1, %v2
  %2 = select i1 %1, i32 %v1, i32 %v2
  ret i32 %2
}

define <2 x i32> @_Z3minDv2_iS_(<2 x i32> %v1, <2 x i32> %v2) nounwind readnone {
  %1 = tail call <2 x i32> @llvm.arm.neon.vmins.v2i32(<2 x i32> %v1, <2 x i32> %v2) nounwind readnone
  ret <2 x i32> %1
}

define <3 x i32> @_Z3minDv3_iS_(<3 x i32> %v1, <3 x i32> %v2) nounwind readnone {
  %1 = shufflevector <3 x i32> %v1, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = shufflevector <3 x i32> %v2, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %3 = tail call <4 x i32   > @llvm.arm.neon.vmins.v4i32(<4 x i32> %1, <4 x i32> %2) nounwind readnone
  %4 = shufflevector <4 x i32> %3, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x i32> %4
}

define <4 x i32> @_Z3minDv4_iS_(<4 x i32> %v1, <4 x i32> %v2) nounwind readnone {
  %1 = tail call <4 x i32> @llvm.arm.neon.vmins.v4i32(<4 x i32> %v1, <4 x i32> %v2) nounwind readnone
  ret <4 x i32> %1
}

define i64 @_Z3minxx(i64 %v1, i64 %v2) nounwind readnone {
  %1 = icmp slt i64 %v1, %v2
  %2 = select i1 %1, i64 %v1, i64 %v2
  ret i64 %2
}

; TODO:  long vector types

define zeroext i8 @_Z3minhh(i8 zeroext %v1, i8 zeroext %v2) nounwind readnone {
  %1 = icmp ult i8 %v1, %v2
  %2 = select i1 %1, i8 %v1, i8 %v2
  ret i8 %2
}

define <2 x i8> @_Z3minDv2_hS_(<2 x i8> %v1, <2 x i8> %v2) nounwind readnone {
  %1 = zext <2 x i8> %v1 to <2 x i32>
  %2 = zext <2 x i8> %v2 to <2 x i32>
  %3 = tail call <2 x i32> @llvm.arm.neon.vminu.v2i32(<2 x i32> %1, <2 x i32> %2) nounwind readnone
  %4 = trunc <2 x i32> %3 to <2 x i8>
  ret <2 x i8> %4
}

define <3 x i8> @_Z3minDv3_hS_(<3 x i8> %v1, <3 x i8> %v2) nounwind readnone {
  %1 = zext <3 x i8> %v1 to <3 x i32>
  %2 = zext <3 x i8> %v2 to <3 x i32>
  %3 = shufflevector <3 x i32> %1, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %4 = shufflevector <3 x i32> %2, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %5 = tail call <4 x i32> @llvm.arm.neon.vminu.v4i32(<4 x i32> %3, <4 x i32> %4) nounwind readnone
  %6 = shufflevector <4 x i32> %5, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %7 = trunc <3 x i32> %6 to <3 x i8>
  ret <3 x i8> %7
}

define <4 x i8> @_Z3minDv4_hS_(<4 x i8> %v1, <4 x i8> %v2) nounwind readnone {
  %1 = zext <4 x i8> %v1 to <4 x i32>
  %2 = zext <4 x i8> %v2 to <4 x i32>
  %3 = tail call <4 x i32> @llvm.arm.neon.vminu.v4i32(<4 x i32> %1, <4 x i32> %2) nounwind readnone
  %4 = trunc <4 x i32> %3 to <4 x i8>
  ret <4 x i8> %4
}

define zeroext i16 @_Z3mintt(i16 zeroext %v1, i16 zeroext %v2) nounwind readnone {
  %1 = icmp ult i16 %v1, %v2
  %2 = select i1 %1, i16 %v1, i16 %v2
  ret i16 %2
}

define <2 x i16> @_Z3minDv2_tS_(<2 x i16> %v1, <2 x i16> %v2) nounwind readnone {
  %1 = zext <2 x i16> %v1 to <2 x i32>
  %2 = zext <2 x i16> %v2 to <2 x i32>
  %3 = tail call <2 x i32> @llvm.arm.neon.vminu.v2i32(<2 x i32> %1, <2 x i32> %2) nounwind readnone
  %4 = trunc <2 x i32> %3 to <2 x i16>
  ret <2 x i16> %4
}

define <3 x i16> @_Z3minDv3_tS_(<3 x i16> %v1, <3 x i16> %v2) nounwind readnone {
  %1 = zext <3 x i16> %v1 to <3 x i32>
  %2 = zext <3 x i16> %v2 to <3 x i32>
  %3 = shufflevector <3 x i32> %1, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %4 = shufflevector <3 x i32> %2, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %5 = tail call <4 x i32> @llvm.arm.neon.vminu.v4i32(<4 x i32> %3, <4 x i32> %4) nounwind readnone
  %6 = shufflevector <4 x i32> %5, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %7 = trunc <3 x i32> %6 to <3 x i16>
  ret <3 x i16> %7
}

define <4 x i16> @_Z3minDv4_tS_(<4 x i16> %v1, <4 x i16> %v2) nounwind readnone {
  %1 = zext <4 x i16> %v1 to <4 x i32>
  %2 = zext <4 x i16> %v2 to <4 x i32>
  %3 = tail call <4 x i32> @llvm.arm.neon.vminu.v4i32(<4 x i32> %1, <4 x i32> %2) nounwind readnone
  %4 = trunc <4 x i32> %3 to <4 x i16>
  ret <4 x i16> %4
}

define i32 @_Z3minjj(i32 %v1, i32 %v2) nounwind readnone {
  %1 = icmp ult i32 %v1, %v2
  %2 = select i1 %1, i32 %v1, i32 %v2
  ret i32 %2
}

define <2 x i32> @_Z3minDv2_jS_(<2 x i32> %v1, <2 x i32> %v2) nounwind readnone {
  %1 = tail call <2 x i32> @llvm.arm.neon.vminu.v2i32(<2 x i32> %v1, <2 x i32> %v2) nounwind readnone
  ret <2 x i32> %1
}

define <3 x i32> @_Z3minDv3_jS_(<3 x i32> %v1, <3 x i32> %v2) nounwind readnone {
  %1 = shufflevector <3 x i32> %v1, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = shufflevector <3 x i32> %v2, <3 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %3 = tail call <4 x i32   > @llvm.arm.neon.vminu.v4i32(<4 x i32> %1, <4 x i32> %2) nounwind readnone
  %4 = shufflevector <4 x i32> %3, <4 x i32> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x i32> %4
}

define <4 x i32> @_Z3minDv4_jS_(<4 x i32> %v1, <4 x i32> %v2) nounwind readnone {
  %1 = tail call <4 x i32> @llvm.arm.neon.vminu.v4i32(<4 x i32> %v1, <4 x i32> %v2) nounwind readnone
  ret <4 x i32> %1
}

define i64 @_Z3minyy(i64 %v1, i64 %v2) nounwind readnone {
  %1 = icmp ult i64 %v1, %v2
  %2 = select i1 %1, i64 %v1, i64 %v2
  ret i64 %2
}

; TODO:  long vector types

define float @_Z3minff(float %v1, float %v2) nounwind readnone {
  %1 = tail call float @_Z4fminff(float %v1, float %v2)
  ret float %1
}

define <2 x float> @_Z3minDv2_fS_(<2 x float> %v1, <2 x float> %v2) nounwind readnone {
  %1 = tail call <2 x float> @_Z4fminDv2_fS_(<2 x float> %v1, <2 x float> %v2)
  ret <2 x float> %1
}

define <2 x float> @_Z3minDv2_ff(<2 x float> %v1, float %v2) nounwind readnone {
  %1 = tail call <2 x float> @_Z4fminDv2_ff(<2 x float> %v1, float %v2)
  ret <2 x float> %1
}

define <3 x float> @_Z3minDv3_fS_(<3 x float> %v1, <3 x float> %v2) nounwind readnone {
  %1 = tail call <3 x float> @_Z4fminDv3_fS_(<3 x float> %v1, <3 x float> %v2)
  ret <3 x float> %1
}

define <3 x float> @_Z3minDv3_ff(<3 x float> %v1, float %v2) nounwind readnone {
  %1 = tail call <3 x float> @_Z4fminDv3_ff(<3 x float> %v1, float %v2)
  ret <3 x float> %1
}

define <4 x float> @_Z3minDv4_fS_(<4 x float> %v1, <4 x float> %v2) nounwind readnone {
  %1 = tail call <4 x float> @_Z4fminDv4_fS_(<4 x float> %v1, <4 x float> %v2)
  ret <4 x float> %1
}

define <4 x float> @_Z3minDv4_ff(<4 x float> %v1, float %v2) nounwind readnone {
  %1 = tail call <4 x float> @_Z4fminDv4_ff(<4 x float> %v1, float %v2)
  ret <4 x float> %1
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;                  YUV                   ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

@yuv_U = internal constant <4 x i32> <i32 0, i32 -100, i32 516, i32 0>, align 16
@yuv_V = internal constant <4 x i32> <i32 409, i32 -208, i32 0, i32 0>, align 16
@yuv_0 = internal constant <4 x i32> <i32 0, i32 0, i32 0, i32 0>, align 16
@yuv_255 = internal constant <4 x i32> <i32 65535, i32 65535, i32 65535, i32 65535>, align 16


define <4 x i8> @_Z18rsYuvToRGBA_uchar4hhh(i8 %pY, i8 %pU, i8 %pV) nounwind readnone alwaysinline {
  %_sy = zext i8 %pY to i32
  %_su = zext i8 %pU to i32
  %_sv = zext i8 %pV to i32

  %_sy2 = add i32 -16, %_sy
  %_sy3 = mul i32 298, %_sy2
  %_su2 = add i32 -128, %_su
  %_sv2 = add i32 -128, %_sv
  %_y = tail call <4 x i32> @smear_4i32(i32 %_sy3) nounwind readnone
  %_u = tail call <4 x i32> @smear_4i32(i32 %_su2) nounwind readnone
  %_v = tail call <4 x i32> @smear_4i32(i32 %_sv2) nounwind readnone

  %mu = load <4 x i32>* @yuv_U, align 8
  %mv = load <4 x i32>* @yuv_V, align 8
  %_u2 = mul <4 x i32> %_u, %mu
  %_v2 = mul <4 x i32> %_v, %mv
  %_y2 = add <4 x i32> %_y, %_u2
  %_y3 = add <4 x i32> %_y2, %_v2

 ; %r1 = tail call <4 x i16> @llvm.arm.neon.vqshiftnsu.v4i16(<4 x i32> %_y3, <4 x i32> <i32 8, i32 8, i32 8, i32 8>) nounwind readnone
;  %r2 = trunc <4 x i16> %r1 to <4 x i8>
;  ret <4 x i8> %r2

  %c0 = load <4 x i32>* @yuv_0, align 8
  %c255 = load <4 x i32>* @yuv_255, align 8
  %r1 = tail call <4 x i32> @llvm.arm.neon.vmaxs.v4i32(<4 x i32> %_y3, <4 x i32> %c0) nounwind readnone
  %r2 = tail call <4 x i32> @llvm.arm.neon.vmins.v4i32(<4 x i32> %r1, <4 x i32> %c255) nounwind readnone
  %r3 = lshr <4 x i32> %r2, <i32 8, i32 8, i32 8, i32 8>
  %r4 = trunc <4 x i32> %r3 to <4 x i8>
  ret <4 x i8> %r4
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;              half_RECIP              ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define float @_Z10half_recipf(float %v) {
  %1 = insertelement <2 x float> undef, float %v, i32 0
  %2 = tail call <2 x float> @llvm.arm.neon.vrecpe.v2f32(<2 x float> %1) nounwind readnone
  %3 = extractelement <2 x float> %2, i32 0
  ret float %3
}

define <2 x float> @_Z10half_recipDv2_f(<2 x float> %v) nounwind readnone {
  %1 = tail call <2 x float> @llvm.arm.neon.vrecpe.v2f32(<2 x float> %v) nounwind readnone
  ret <2 x float> %1
}

define <3 x float> @_Z10half_recipDv3_f(<3 x float> %v) nounwind readnone {
  %1 = shufflevector <3 x float> %v, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = tail call <4 x float> @llvm.arm.neon.vrecpe.v4f32(<4 x float> %1) nounwind readnone
  %3 = shufflevector <4 x float> %2, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x float> %3
}

define <4 x float> @_Z10half_recipDv4_f(<4 x float> %v) nounwind readnone {
  %1 = tail call <4 x float> @llvm.arm.neon.vrecpe.v4f32(<4 x float> %v) nounwind readnone
  ret <4 x float> %1
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;              half_SQRT               ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define float @_Z9half_sqrtf(float %v) {
  %1 = insertelement <2 x float> undef, float %v, i32 0
  %2 = tail call <2 x float> @llvm.arm.neon.vrsqrte.v2f32(<2 x float> %1) nounwind readnone
  %3 = tail call <2 x float> @llvm.arm.neon.vrecpe.v2f32(<2 x float> %2) nounwind readnone
  %4 = extractelement <2 x float> %3, i32 0
  ret float %4
}

define <2 x float> @_Z9half_sqrtDv2_f(<2 x float> %v) nounwind readnone {
  %1 = tail call <2 x float> @llvm.arm.neon.vrsqrte.v2f32(<2 x float> %v) nounwind readnone
  %2 = tail call <2 x float> @llvm.arm.neon.vrecpe.v2f32(<2 x float> %1) nounwind readnone
  ret <2 x float> %2
}

define <3 x float> @_Z9half_sqrtDv3_f(<3 x float> %v) nounwind readnone {
  %1 = shufflevector <3 x float> %v, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = tail call <4 x float> @llvm.arm.neon.vrsqrte.v4f32(<4 x float> %1) nounwind readnone
  %3 = tail call <4 x float> @llvm.arm.neon.vrecpe.v4f32(<4 x float> %2) nounwind readnone
  %4 = shufflevector <4 x float> %3, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x float> %4
}

define <4 x float> @_Z9half_sqrtDv4_f(<4 x float> %v) nounwind readnone {
  %1 = tail call <4 x float> @llvm.arm.neon.vrsqrte.v4f32(<4 x float> %v) nounwind readnone
  %2 = tail call <4 x float> @llvm.arm.neon.vrecpe.v4f32(<4 x float> %1) nounwind readnone
  ret <4 x float> %2
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;              half_RSQRT              ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define float @_Z10half_rsqrtf(float %v) {
  %1 = insertelement <2 x float> undef, float %v, i32 0
  %2 = tail call <2 x float> @llvm.arm.neon.vrsqrte.v2f32(<2 x float> %1) nounwind readnone
  %3 = extractelement <2 x float> %2, i32 0
  ret float %3
}

define <2 x float> @_Z10half_rsqrtDv2_f(<2 x float> %v) nounwind readnone {
  %1 = tail call <2 x float> @llvm.arm.neon.vrsqrte.v2f32(<2 x float> %v) nounwind readnone
  ret <2 x float> %1
}

define <3 x float> @_Z10half_rsqrtDv3_f(<3 x float> %v) nounwind readnone {
  %1 = shufflevector <3 x float> %v, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = tail call <4 x float> @llvm.arm.neon.vrsqrte.v4f32(<4 x float> %1) nounwind readnone
  %3 = shufflevector <4 x float> %2, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x float> %3
}

define <4 x float> @_Z10half_rsqrtDv4_f(<4 x float> %v) nounwind readnone {
  %1 = tail call <4 x float> @llvm.arm.neon.vrsqrte.v4f32(<4 x float> %v) nounwind readnone
  ret <4 x float> %1
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;              matrix                    ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

declare <4 x float> @llvm.arm.neon.vld1.v4f32(i8*, i32) nounwind readonly

%struct.rs_matrix4x4 = type { [16 x float] }
%struct.rs_matrix3x3 = type { [9 x float] }
%struct.rs_matrix2x2 = type { [4 x float] }

define internal <4 x float> @smear_f(float %in) nounwind readnone alwaysinline {
  %1 = insertelement <4 x float> undef, float %in, i32 0
  %2 = insertelement <4 x float> %1, float %in, i32 1
  %3 = insertelement <4 x float> %2, float %in, i32 2
  %4 = insertelement <4 x float> %3, float %in, i32 3
  ret <4 x float> %4
}


define <3 x float> @_Z16rsMatrixMultiplyPK12rs_matrix3x3Dv3_f(%struct.rs_matrix3x3* nocapture %m, <3 x float> %in) nounwind readonly {
  %x0 = extractelement <3 x float> %in, i32 0
  %x = tail call <4 x float> @smear_f(float %x0) nounwind readnone
  %y0 = extractelement <3 x float> %in, i32 1
  %y = tail call <4 x float> @smear_f(float %y0) nounwind readnone
  %z0 = extractelement <3 x float> %in, i32 2
  %z = tail call <4 x float> @smear_f(float %z0) nounwind readnone

  %px = getelementptr inbounds %struct.rs_matrix3x3* %m, i32 0, i32 0, i32 0
  %px2 = bitcast float* %px to i8*
  %xm = call <4 x float> @llvm.arm.neon.vld1.v4f32(i8* %px2, i32 4) nounwind

  %py = getelementptr inbounds %struct.rs_matrix3x3* %m, i32 0, i32 0, i32 3
  %py2 = bitcast float* %py to i8*
  %ym = call <4 x float> @llvm.arm.neon.vld1.v4f32(i8* %py2, i32 4) nounwind

  %pz = getelementptr inbounds %struct.rs_matrix3x3* %m, i32 0, i32 0, i32 5
  %pz2 = bitcast float* %pz to i8*
  %zm2 = call <4 x float> @llvm.arm.neon.vld1.v4f32(i8* %pz2, i32 4) nounwind
  %zm = shufflevector <4 x float> %zm2, <4 x float> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 4>

  %a1 = fmul <4 x float> %x, %xm
  %a2 = fmul <4 x float> %y, %ym
  %a3 = fadd <4 x float> %a1, %a2
  %a4 = fmul <4 x float> %z, %zm
  %a5 = fadd <4 x float> %a4, %a3
  %a6 = shufflevector <4 x float> %a5, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x float> %a6
}

define <3 x float> @_Z16rsMatrixMultiplyPK12rs_matrix3x3Dv2_f(%struct.rs_matrix3x3* nocapture %m, <2 x float> %in) nounwind readonly {
  %x0 = extractelement <2 x float> %in, i32 0
  %x = tail call <4 x float> @smear_f(float %x0) nounwind readnone
  %y0 = extractelement <2 x float> %in, i32 1
  %y = tail call <4 x float> @smear_f(float %y0) nounwind readnone

  %px = getelementptr inbounds %struct.rs_matrix3x3* %m, i32 0, i32 0, i32 0
  %px2 = bitcast float* %px to <4 x float>*
  %xm = load <4 x float>* %px2, align 4
  %py = getelementptr inbounds %struct.rs_matrix3x3* %m, i32 0, i32 0, i32 3
  %py2 = bitcast float* %py to <4 x float>*
  %ym = load <4 x float>* %py2, align 4

  %a1 = fmul <4 x float> %x, %xm
  %a2 = fmul <4 x float> %y, %ym
  %a3 = fadd <4 x float> %a1, %a2
  %a4 = shufflevector <4 x float> %a3, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x float> %a4
}

define <4 x float> @_Z16rsMatrixMultiplyPK12rs_matrix4x4Dv4_f(%struct.rs_matrix4x4* nocapture %m, <4 x float> %in) nounwind readonly {
  %x0 = extractelement <4 x float> %in, i32 0
  %x = tail call <4 x float> @smear_f(float %x0) nounwind readnone
  %y0 = extractelement <4 x float> %in, i32 1
  %y = tail call <4 x float> @smear_f(float %y0) nounwind readnone
  %z0 = extractelement <4 x float> %in, i32 2
  %z = tail call <4 x float> @smear_f(float %z0) nounwind readnone
  %w0 = extractelement <4 x float> %in, i32 3
  %w = tail call <4 x float> @smear_f(float %w0) nounwind readnone

  %px = getelementptr inbounds %struct.rs_matrix4x4* %m, i32 0, i32 0, i32 0
  %px2 = bitcast float* %px to <4 x float>*
  %xm = load <4 x float>* %px2, align 4
  %py = getelementptr inbounds %struct.rs_matrix4x4* %m, i32 0, i32 0, i32 4
  %py2 = bitcast float* %py to <4 x float>*
  %ym = load <4 x float>* %py2, align 4
  %pz = getelementptr inbounds %struct.rs_matrix4x4* %m, i32 0, i32 0, i32 8
  %pz2 = bitcast float* %pz to <4 x float>*
  %zm = load <4 x float>* %pz2, align 4
  %pw = getelementptr inbounds %struct.rs_matrix4x4* %m, i32 0, i32 0, i32 12
  %pw2 = bitcast float* %pw to <4 x float>*
  %wm = load <4 x float>* %pw2, align 4

  %a1 = fmul <4 x float> %x, %xm
  %a2 = fmul <4 x float> %y, %ym
  %a3 = fadd <4 x float> %a1, %a2
  %a4 = fmul <4 x float> %z, %zm
  %a5 = fadd <4 x float> %a3, %a4
  %a6 = fmul <4 x float> %w, %wm
  %a7 = fadd <4 x float> %a5, %a6
  ret <4 x float> %a7
}

define <4 x float> @_Z16rsMatrixMultiplyPK12rs_matrix4x4Dv3_f(%struct.rs_matrix4x4* nocapture %m, <3 x float> %in) nounwind readonly {
  %x0 = extractelement <3 x float> %in, i32 0
  %x = tail call <4 x float> @smear_f(float %x0) nounwind readnone
  %y0 = extractelement <3 x float> %in, i32 1
  %y = tail call <4 x float> @smear_f(float %y0) nounwind readnone
  %z0 = extractelement <3 x float> %in, i32 2
  %z = tail call <4 x float> @smear_f(float %z0) nounwind readnone

  %px = getelementptr inbounds %struct.rs_matrix4x4* %m, i32 0, i32 0, i32 0
  %px2 = bitcast float* %px to <4 x float>*
  %xm = load <4 x float>* %px2, align 4
  %py = getelementptr inbounds %struct.rs_matrix4x4* %m, i32 0, i32 0, i32 4
  %py2 = bitcast float* %py to <4 x float>*
  %ym = load <4 x float>* %py2, align 4
  %pz = getelementptr inbounds %struct.rs_matrix4x4* %m, i32 0, i32 0, i32 8
  %pz2 = bitcast float* %pz to <4 x float>*
  %zm = load <4 x float>* %pz2, align 4
  %pw = getelementptr inbounds %struct.rs_matrix4x4* %m, i32 0, i32 0, i32 12
  %pw2 = bitcast float* %pw to <4 x float>*
  %wm = load <4 x float>* %pw2, align 4

  %a1 = fmul <4 x float> %x, %xm
  %a2 = fadd <4 x float> %wm, %a1
  %a3 = fmul <4 x float> %y, %ym
  %a4 = fadd <4 x float> %a2, %a3
  %a5 = fmul <4 x float> %z, %zm
  %a6 = fadd <4 x float> %a4, %a5
  ret <4 x float> %a6
}

define <4 x float> @_Z16rsMatrixMultiplyPK12rs_matrix4x4Dv2_f(%struct.rs_matrix4x4* nocapture %m, <2 x float> %in) nounwind readonly {
  %x0 = extractelement <2 x float> %in, i32 0
  %x = tail call <4 x float> @smear_f(float %x0) nounwind readnone
  %y0 = extractelement <2 x float> %in, i32 1
  %y = tail call <4 x float> @smear_f(float %y0) nounwind readnone

  %px = getelementptr inbounds %struct.rs_matrix4x4* %m, i32 0, i32 0, i32 0
  %px2 = bitcast float* %px to <4 x float>*
  %xm = load <4 x float>* %px2, align 4
  %py = getelementptr inbounds %struct.rs_matrix4x4* %m, i32 0, i32 0, i32 4
  %py2 = bitcast float* %py to <4 x float>*
  %ym = load <4 x float>* %py2, align 4
  %pw = getelementptr inbounds %struct.rs_matrix4x4* %m, i32 0, i32 0, i32 12
  %pw2 = bitcast float* %pw to <4 x float>*
  %wm = load <4 x float>* %pw2, align 4

  %a1 = fmul <4 x float> %x, %xm
  %a2 = fadd <4 x float> %wm, %a1
  %a3 = fmul <4 x float> %y, %ym
  %a4 = fadd <4 x float> %a2, %a3
  ret <4 x float> %a4
}



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;              pixel ops                 ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


@fc_255.0 = internal constant <4 x float> <float 255.0, float 255.0, float 255.0, float 255.0>, align 16
@fc_0.5 = internal constant <4 x float> <float 0.5, float 0.5, float 0.5, float 0.5>, align 16
@fc_0 = internal constant <4 x float> <float 0.0, float 0.0, float 0.0, float 0.0>, align 16

declare <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %in) nounwind readnone
declare <4 x float> @_Z14convert_float4Dv4_h(<4 x i8> %in) nounwind readnone

; uchar4 __attribute__((overloadable)) rsPackColorTo8888(float4 color)
define <4 x i8> @_Z17rsPackColorTo8888Dv4_f(<4 x float> %color) nounwind readnone {
    %f255 = load <4 x float>* @fc_255.0, align 16
    %f05 = load <4 x float>* @fc_0.5, align 16
    %f0 = load <4 x float>* @fc_0, align 16
    %v1 = fmul <4 x float> %f255, %color
    %v2 = fadd <4 x float> %f05, %v1
    %v3 = tail call <4 x float> @_Z5clampDv4_fS_S_(<4 x float> %v2, <4 x float> %f0, <4 x float> %f255) nounwind readnone
    %v4 = tail call <4 x i8> @_Z14convert_uchar4Dv4_f(<4 x float> %v3) nounwind readnone
    ret <4 x i8> %v4
}

; uchar4 __attribute__((overloadable)) rsPackColorTo8888(float3 color)
define <4 x i8> @_Z17rsPackColorTo8888Dv3_f(<3 x float> %color) nounwind readnone {
    %1 = shufflevector <3 x float> %color, <3 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
    %2 = insertelement <4 x float> %1, float 1.0, i32 3
    %3 = tail call <4 x i8> @_Z17rsPackColorTo8888Dv4_f(<4 x float> %2) nounwind readnone
    ret <4 x i8> %3
}

; uchar4 __attribute__((overloadable)) rsPackColorTo8888(float r, float g, float b)
define <4 x i8> @_Z17rsPackColorTo8888fff(float %r, float %g, float %b) nounwind readnone {
    %1 = insertelement <4 x float> undef, float %r, i32 0
    %2 = insertelement <4 x float> %1, float %g, i32 1
    %3 = insertelement <4 x float> %2, float %b, i32 2
    %4 = insertelement <4 x float> %3, float 1.0, i32 3
    %5 = tail call <4 x i8> @_Z17rsPackColorTo8888Dv4_f(<4 x float> %4) nounwind readnone
    ret <4 x i8> %5
}

; uchar4 __attribute__((overloadable)) rsPackColorTo8888(float r, float g, float b, float a)
define <4 x i8> @_Z17rsPackColorTo8888ffff(float %r, float %g, float %b, float %a) nounwind readnone {
    %1 = insertelement <4 x float> undef, float %r, i32 0
    %2 = insertelement <4 x float> %1, float %g, i32 1
    %3 = insertelement <4 x float> %2, float %b, i32 2
    %4 = insertelement <4 x float> %3, float %a, i32 3
    %5 = tail call <4 x i8> @_Z17rsPackColorTo8888Dv4_f(<4 x float> %4) nounwind readnone
    ret <4 x i8> %5
}

