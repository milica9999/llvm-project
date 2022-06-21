; RUN: opt %s -passes=myhelloworld -S -o - | FileCheck %s
; ModuleID = 'proba.c'
source_filename = "proba.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn uwtable
define dso_local i32 @main() local_unnamed_addr #0 !dbg !9 {
; CHECK-NOT: call void @llvm.dbg.value(metadata i32 1, metadata !14, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.value(metadata i32 1, metadata !14, metadata !DIExpression()), !dbg !17
; CHECK-NOT: call void @llvm.dbg.value(metadata i32 6, metadata !15, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.value(metadata i32 6, metadata !15, metadata !DIExpression()), !dbg !17
; CHECK-NOT: call void @llvm.dbg.value(metadata i32 1, metadata !16, metadata !DIExpression(DW_OP_plus_uconst, 6, DW_OP_stack_value)), !dbg !17
  call void @llvm.dbg.value(metadata i32 1, metadata !16, metadata !DIExpression(DW_OP_plus_uconst, 6, DW_OP_stack_value)), !dbg !17
  ret i32 0, !dbg !18
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone willreturn uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 41d5033eb162cb92b684855166cabfa3983b74c6)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "proba.c", directory: "/home/syrmia/Desktop/proba", checksumkind: CSK_MD5, checksum: "95226887c8d7b32146baefc39ec0b3d7")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{!"clang version 15.0.0 (https://github.com/llvm/llvm-project.git 41d5033eb162cb92b684855166cabfa3983b74c6)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !10, scopeLine: 1, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !13)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !{!14, !15, !16}
!14 = !DILocalVariable(name: "a", scope: !9, file: !1, line: 2, type: !12)
!15 = !DILocalVariable(name: "b", scope: !9, file: !1, line: 2, type: !12)
!16 = !DILocalVariable(name: "c", scope: !9, file: !1, line: 3, type: !12)
!17 = !DILocation(line: 0, scope: !9)
!18 = !DILocation(line: 4, column: 2, scope: !9)
