package kr.kh.tmp.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CommentCriteria extends Criteria {

	int po_num;

	@Override
	public String toString() {
		return "CommentCriteria [po_num=" + po_num + "," + super.toString() +  "]";
	}
	
}