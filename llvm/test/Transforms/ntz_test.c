// RUN: clang -target riscv64-linux-unknown-elf -no-canonical-prefixes --gcc-toolchain=/home/syrmia/gcc/riscv-toolchain/install --sysroot=/home/syrmia/gcc/riscv-toolchain/install/sysroot -O2 -S %s -emit-llvm -static -o - | opt -aggressive-instcombine -mtriple riscv64-linux-elf -S -o - | /home/syrmia/Desktop/llvm/llvm-project/build/bin/FileCheck %s

static const char u = 0;
// CHECK: entry:
// CHECK: %sub = sub i32 0, %x
// CHECK: %and = and i32 %sub, %x
// CHECK: %mul = mul i32 %and, 72416175
// CHECK: %shr = lshr i32 %mul, 26
// CHECK: %idxprom = zext i32 %shr to i64
// CHECK: %arrayidx = getelementptr inbounds [64 x i8], ptr @ntz_seals_alg.table, i64 0, i64 %idxprom
// CHECK: %0 = load i8, ptr %arrayidx, align 1, !tbaa !6
// CHECK: %conv = zext i8 %0 to i32
// CHECK: ret i32 %conv
int ntz_seals_alg(unsigned x) {
  static char table[64] = {32, 0, 1,  12, 2,  6,  u,  13, 10, 4,  u,  u,  8,
                           u,  u, 25, 31, 11, 5,  u,  u,  u,  u,  u,  30, u,
                           u,  u, u,  23, u,  19, 3,  u,  7,  u,  u,  u,  u,
                           14, u, u,  u,  u,  u,  21, 27, 15, 9,  u,  u,  24,
                           u,  u, 20, 26, 29, u,  22, 18, 28, 17, 16, u};
  x = (x & -x) * 0x0450FBAF;
  return table[x >> 26];
}

// CHECK: entry:
// CHECK: %cmp = icmp eq i32 %x, 0
// CHECK: br i1 %cmp, label %return, label %if.end

// CHECK: if.end:                                        
// CHECK: %sub = sub i32 0, %x
// CHECK: %and = and i32 %sub, %x
// CHECK: %mul = mul i32 %and, 81224991
// CHECK: %shr = lshr i32 %mul, 27
// CHECK: %idxprom = zext i32 %shr to i64
// CHECK: %arrayidx = getelementptr inbounds [32 x i8], ptr @ntz_deBruijn_cycle.table, i64 0, i64 %idxprom
// CHECK: %0 = load i8, ptr %arrayidx, align 1, !tbaa !6
// CHECK: %conv = zext i8 %0 to i32
// CHECK: br label %return

// CHECK: return:                                           
// CHECK: %retval.0 = phi i32 [ %conv, %if.end ], [ 32, %entry ]
// CHECK: ret i32 %retval.0
int ntz_deBruijn_cycle(unsigned x) {
  static char table[32] = {0,  1,  2,  24, 3,  19, 6,  25, 31, 23, 18,
                           5,  21, 9,  15, 11, 22, 4,  20, 10, 16, 7,
                           12, 26, 30, 17, 8,  14, 29, 13, 28, 27};
  if (x == 0)
    return 32;
  x = (x & -x) * 0x04D7651F;
  return table[x >> 27];
}


// CHECK: entry:
// CHECK: %sub = sub i32 0, %x
// CHECK: %and = and i32 %sub, %x
// CHECK: %rem = urem i32 %and, 37
// CHECK: %idxprom = zext i32 %rem to i64
// CHECK: %arrayidx = getelementptr inbounds [37 x i8], ptr @ntz_reisers_slg.table, i64 0, i64 %idxprom
// CHECK: %0 = load i8, ptr %arrayidx, align 1, !tbaa !6
// CHECK: %conv = zext i8 %0 to i32
// CHECK: ret i32 %conv
int ntz_reisers_slg(unsigned x) {
  static char table[37] = {32, 0, 1,  26, 2,  23, 27, u,  3,  16, 24, 30, 28,
                           11, u, 13, 4,  7,  17, u,  25, 22, 31, 15, 29, 10,
                           12, 6, u,  21, 14, 9,  5,  20, 8,  19, 18};
  x = (x & -x) % 37;
  return table[x];
}

// CHECK: entry:
// CHECK: %0 = tail call i32 @llvm.cttz.i32(i32 %x, i1 true), !range !9
// CHECK: ret i32 %0
int built_in_cttz(unsigned x) { return __builtin_ctz(x); }
