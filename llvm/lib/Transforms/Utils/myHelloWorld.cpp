#include "llvm/Transforms/Utils/myHelloWorld.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/BasicBlock.h"

using namespace llvm;

PreservedAnalyses myHelloWorldPass::run(Function &F, FunctionAnalysisManager &AM) {
	errs() << F.getName() << "\n";
	int numDebugInstr = 0;
	SmallVector<Instruction *, 128> Worklist;
	for (Function::iterator bb = F.begin(); bb != F.end(); bb++) {
		for(BasicBlock::iterator fit = bb->begin(); fit != bb->end(); fit++){
			//Instruction *I = fit++;
			if(isa<DbgInfoIntrinsic>(*fit)){
				Worklist.push_back(&(*fit));
				numDebugInstr++;
			}
        	}
        }
        while (!Worklist.empty()) {
      		Instruction *inst = Worklist.pop_back_val();
      		inst->eraseFromParent();
      	}	
	errs() << numDebugInstr << "\n";
  	return PreservedAnalyses::all();
}
