; ModuleID = 'cttz_zero_return_test.c'
; RUN: llc -mtriple=riscv64 -mattr=+zbb -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64ZBB

source_filename = "cttz_zero_return_test.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-linux-elf-unknown"

@indexes = dso_local local_unnamed_addr global [64 x i32] [i32 63, i32 0, i32 58, i32 1, i32 59, i32 47, i32 53, i32 2, i32 60, i32 39, i32 48, i32 27, i32 54, i32 33, i32 42, i32 3, i32 61, i32 51, i32 37, i32 40, i32 49, i32 18, i32 28, i32 20, i32 55, i32 30, i32 34, i32 11, i32 43, i32 14, i32 22, i32 4, i32 62, i32 57, i32 46, i32 52, i32 38, i32 26, i32 32, i32 41, i32 50, i32 36, i32 17, i32 19, i32 29, i32 10, i32 13, i32 21, i32 56, i32 45, i32 25, i32 31, i32 35, i32 16, i32 9, i32 12, i32 44, i32 24, i32 15, i32 8, i32 23, i32 7, i32 6, i32 5], align 4
@global_x = dso_local local_unnamed_addr global i32 0, align 4

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind readonly willreturn
define dso_local signext i32 @ctz_dereferencing_pointer(i64* nocapture noundef readonly %b) local_unnamed_addr #0 {
; RV64ZBB-LABEL: ctz_dereferencing_pointer:            
; RV64ZBB:       # %bb.0:                              
; RV64ZBB-NEXT:	     ld	a0, 0(a0)
; RV64ZBB-NEXT:	     ctz a0, a0
; RV64ZBB-NEXT:	     andi a0, a0, 63
; RV64ZBB-NEXT:	     ret
entry:
  %0 = load i64, i64* %b, align 8, !tbaa !6
  %1 = tail call i64 @llvm.cttz.i64(i64 %0, i1 true), !range !10
  %2 = icmp eq i64 %0, 0
  %3 = trunc i64 %1 to i32
  %4 = select i1 %2, i32 0, i32 %3
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define dso_local signext i32 @ctz1(i32 noundef signext %x) local_unnamed_addr #1 {
; RV64ZBB-LABEL: ctz1:                              
; RV64ZBB:       # %bb.0:                            
; RV64ZBB-NEXT:	   ctzw	a0, a0
; RV64ZBB-NEXT:	   ret
entry:
  %0 = tail call i32 @llvm.cttz.i32(i32 %x, i1 true), !range !11
  %1 = icmp eq i32 %x, 0
  %conv = select i1 %1, i32 0, i32 %0
  ret i32 %conv
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define dso_local signext i32 @ctz2(i32 noundef signext %x) local_unnamed_addr #1 {
; RV64ZBB-LABEL: ctz2:                              
; RV64ZBB:       # %bb.0:                            
; RV64ZBB-NEXT:	   ctzw	a0, a0
; RV64ZBB-NEXT:	   ret
entry:
  %0 = tail call i32 @llvm.cttz.i32(i32 %x, i1 false), !range !11
  ret i32 %0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define dso_local signext i32 @ctz3(i32 noundef signext %x) local_unnamed_addr #1 {
; RV64ZBB-LABEL: ctz3:                              
; RV64ZBB:       # %bb.0:                            
; RV64ZBB-NEXT:	   ctzw	a0, a0
; RV64ZBB-NEXT:	   ret
entry:
  %0 = tail call i32 @llvm.cttz.i32(i32 %x, i1 false), !range !11
  ret i32 %0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define dso_local signext i32 @ctz4(i64 noundef %b) local_unnamed_addr #1 {
; RV64ZBB-LABEL:  ctz4:                        
; RV64ZBB:        # %bb.0:                     
; RV64ZBB-NEXT:	    ctz	a0, a0
; RV64ZBB-NEXT:	    andi a0, a0, 63
; RV64ZBB-NEXT:	    ret
entry:
  %0 = tail call i64 @llvm.cttz.i64(i64 %b, i1 true), !range !10
  %1 = icmp eq i64 %b, 0
  %2 = trunc i64 %0 to i32
  %3 = select i1 %1, i32 0, i32 %2
  ret i32 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define dso_local signext i32 @ctz5(i32 noundef signext %x) local_unnamed_addr #1 {
; RV64ZBB-LABEL: ctz5:                              
; RV64ZBB:       # %bb.0:                            
; RV64ZBB-NEXT:	   ctzw	a0, a0
; RV64ZBB-NEXT:	   ret
entry:
  %0 = tail call i32 @llvm.cttz.i32(i32 %x, i1 true), !range !11
  %1 = icmp eq i32 %x, 0
  %conv = select i1 %1, i32 0, i32 %0
  ret i32 %conv
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readonly willreturn
define dso_local signext i32 @ctz6(i64 noundef %n) local_unnamed_addr #2 {
; RV64ZBB-LABEL:  ctz6:                        
; RV64ZBB:        # %bb.0:                     
; RV64ZBB-NEXT:	    ctz	a0, a0
; RV64ZBB-NEXT:	    andi a0, a0, 63
; RV64ZBB-NEXT:	    ret
entry:
  %0 = tail call i64 @llvm.cttz.i64(i64 %n, i1 true), !range !10
  %1 = icmp eq i64 %n, 0
  %2 = trunc i64 %0 to i32
  %3 = select i1 %1, i32 63, i32 %2
  ret i32 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define dso_local signext i32 @ctz7(i32 noundef signext %x) local_unnamed_addr #1 {
; RV64ZBB-LABEL: ctz7:                              
; RV64ZBB:       # %bb.0:                            
; RV64ZBB-NEXT:	   ctzw	a0, a0
; RV64ZBB-NEXT:	   ret
entry:
  %0 = tail call i32 @llvm.cttz.i32(i32 %x, i1 true), !range !11
  %1 = icmp eq i32 %x, 0
  %conv = select i1 %1, i32 0, i32 %0
  ret i32 %conv
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define dso_local signext i32 @ctz8(i32 noundef signext %v) local_unnamed_addr #1 {
; RV64ZBB-LABEL: ctz8:                              
; RV64ZBB:       # %bb.0:                            
; RV64ZBB-NEXT:	   ctzw	a0, a0
; RV64ZBB-NEXT:	   ret
entry:
  %0 = tail call i32 @llvm.cttz.i32(i32 %v, i1 true), !range !11
  %1 = icmp eq i32 %v, 0
  %2 = select i1 %1, i32 31, i32 %0
  ret i32 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readonly willreturn
define dso_local signext i32 @globalVar() local_unnamed_addr #2 {
; RV64ZBB-LABEL:  globalVar:                       
; RV64ZBB:        # %bb.0:                           
; RV64ZBB-NEXT:	    lui	a0, %hi(global_x)
; RV64ZBB-NEXT:	    lw a0, %lo(global_x)(a0)
; RV64ZBB-NEXT:	    ctzw a0, a0
; RV64ZBB-NEXT:	    ret
entry:
  %0 = load i32, i32* @global_x, align 4, !tbaa !12
  %1 = tail call i32 @llvm.cttz.i32(i32 %0, i1 true), !range !11
  %2 = icmp eq i32 %0, 0
  %conv = select i1 %2, i32 0, i32 %1
  ret i32 %conv
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.cttz.i64(i64, i1 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.cttz.i32(i32, i1 immarg) #3

attributes #0 = { argmemonly mustprogress nofree norecurse nosync nounwind readonly willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+relax,+zbb,-save-restore" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+relax,+zbb,-save-restore" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind readonly willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+relax,+zbb,-save-restore" }
attributes #3 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"lp64"}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 1, !"SmallDataLimit", i32 8}
!5 = !{!"clang version 15.0.0 (https://github.com/milica9999/llvm-project.git d381bef33ce06372f0d5720f6f45777056a253b6)"}
!6 = !{!7, !7, i64 0}
!7 = !{!"long long", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{i64 0, i64 65}
!11 = !{i32 0, i32 33}
!12 = !{!13, !13, i64 0}
!13 = !{!"int", !8, i64 0}
