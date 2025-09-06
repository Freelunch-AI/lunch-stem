# COMP790: (Deep) Learning with Limited Labeled Data (DL3D)

Instructor: [Colin Raffel](http://colinraffel.com)

Meeting time: Mondays and Wednesdays, 2:40-3:55pm

Office hours: Tuesdays from 9:00-10:00am, Thursdays and Fridays from 3:00-4:00pm

"Deep learning" has produced dramatic advances across a wide variety of domains, including computer vision, natural language processing, speech recognition, and beyond.
Applying deep learning typically involves training a model using a large labeled dataset.
The reliance on a labeled data can be an issue, particularly in applications where labeling involves paying a human expert.
However, there have been many recent advances that substantially mitigate the need for labeled data.
In this course, we'll read and discuss the papers proposing these methods, with a particular focus on semi-supervised and transfer learning methods applied to computer vision and natural language processing.

The structure of this course and some of the materials are based on [Alec Jacobson](http://www.cs.toronto.edu/~jacobson/)'s [CSC2521](https://github.com/alecjacobson/seminar-on-geometry-and-animation) course at the University of Toronto.

## Prerequisites

Students must have experience with machine learning (preferably deep learning), including the necessary mathematical background (linear algebra and statistics) as well as the ability to implement machine learning algorithms.
Before taking the class, you should be able to read a recent machine learning conference paper and come away with a decent understanding of the basic concepts and ideas proposed in the paper (but not necessarily a deep, perfect understanding of every last detail).

## Course Structure

This class is mainly a paper-reading seminar covering recent important papers on the subject of (deep) learning from limited labels.
There will also be an open-ended final project that will involve extending some of the papers we read in the class through additional experiments and a short write-up.

### Readings

For much of the semester, each class will involve the presentation and discussion of one paper.
Before each class, everyone is required to have read the paper.
Students will be divided into two groups.
One group of students will present on Mondays and the other on Wednesdays.
In a given class session, students in the presenting group will each be given a rotating role (described below).
This role defines the lens through which they read the paper and determines what they prepare for the group in-class discussion.
Note that *two* people will team up for each role, and the pairing will rotate each class.
You and your partner should decide how to equally divide the work for a given role/paper/session.
Students in the non-presenting group are also required to read the paper, complete a quick exercise (described below), and come to class ready to discuss.
All students will obtain a thorough understanding of the chosen papers and will develop their paper reading, literature review, and prototyping skills.

#### Presentation roles

This seminar is organized around the different "roles" students play each week:
Reviewer, Archaeologist, Researcher, Practitioner, Hacker, and Private Investigator.

  - **Reviewer:** Complete a full---critical but not necessarily negative---review of the paper. Follow the [guidelines for NeurIPS reviewers](https://nips.cc/Conferences/2020/PaperInformation/ReviewerGuidelines) (under "Review Content"), taking note of the example reviews included therein. In particular, please answer questions 1 to 10 under "Review Content", including assigning an overall score.
  - **Archaeologist:** Determine where this paper sits in the context of previous and subsequent work. Find and report on one prior paper that substantially influenced the current paper and one newer paper that cites this current paper.
  - **Researcher:** Propose an imaginary follow-up project -- not just based on the current but only possible due to the existence and success of the current paper.
  - **Practitioner:** Propose a new application for the method in the paper (not already discussed in class), and discuss at least one positive and negative impact of this application.
  - **Hacker:** Implement a small part of the paper on a small dataset or toy problem. Prepare to share the core code of the algorithm to the class. Do not simply download and run an existing implementation - you should implement at least a core method from the paper, though you are welcome to use (and give credit to) an existing implementation for "backbone" code (e.g. model building, data loading, training loop, etc.).
  - **Private Investigator:** Find out background information on one of the paper authors. Where have they worked? What did they study? What previous projects might have led to working on this one? What do you think motivated them to work on this project? Feel free to contact the authors, but remember to be courteous, polite, and on-topic. Write that you're in Prof. Raffel's seminar and include a link to this page.

#### Non-presenter assignment

If you aren't in the presenting group during a given class period, please come to class with:
  1. A new title for the paper and/or a new name for the algorithm it proposes
  1. At least one question about the paper (either something you're confused about or something you'd like to hear discussed more)

### Final Project

All students in the class will write a "mini-paper" as a final project.
The paper should extend one or more papers we covered in the class.
Students should write code and carry out additional experiments and then write up the results in a standard conference paper format.

Students are welcome to work in groups on the final project.
I will expect a group of two students to put twice as much work into the final project than for a sole-author project, and similarly for larger groups.
I'd encourage students to not work alone and I won't allow groups with five or more people without special permission.
Students in groups are required to include a "contributions" paragraph in their paper that concretely lists each author's contributions.
The maximum paper length for a given final project write-up is `3 + n_students` *not including references or the contributions paragraph*, where `n_students` is the number of people in the group that worked on the project.

All groups will be required to submit a project proposal by the start of class on October 19th.
The project proposal is a single-paragraph description of what you intend to do (experiments, datasets, methods, etc.)
Groups will present their final projects during the final exam period.
All students in each group are required to present some material during the final presentation.

## Schedule

The papers we are reading were chosen by popular vote from [this list](https://github.com/craffel/dl3d-seminar/blob/master/papers.md) during the first week of class.

| Date | Content |
|----|----|
| Mon, 8/10 | Course introduction, logistics, and background lecture |
| Wed, 8/12 | [Pseudo-Label : The Simple and Efficient Semi-Supervised Learning Method for Deep Neural Networks](http://deeplearning.net/wp-content/uploads/2013/03/pseudo_label_final.pdf) (presented by Colin) |
| Mon, 8/17 | [Semi-Supervised Learning with Deep Generative Models](https://arxiv.org/abs/1406.5298) |
| Wed, 8/19 | [Semi-Supervised Learning with Normalizing Flows](https://arxiv.org/abs/1912.13025) |
| Mon, 8/24 | [Temporal Ensembling for Semi-Supervised Learning](https://arxiv.org/abs/1610.02242) |
| Wed, 8/26 | [Virtual Adversarial Training: A Regularization Method for Supervised and Semi-Supervised Learning](https://arxiv.org/abs/1704.03976) |
| Mon, 8/31 | [MixMatch: A Holistic Approach to Semi-Supervised Learning](https://arxiv.org/abs/1905.02249) |
| Wed, 9/2 | [Pseudo-Labeling and Confirmation Bias in Deep Semi-Supervised Learning](https://arxiv.org/abs/1908.02983) |
| Mon, 9/7 | No class (labor day) |
| Wed, 9/9 | [Unsupervised Data Augmentation for Consistency Training](https://arxiv.org/abs/1904.12848) |
| Mon, 9/14 | [FixMatch: Simplifying Semi-Supervised Learning with Consistency and Confidence](https://arxiv.org/abs/2001.07685) |
| Wed, 9/16 | [S4L: Self-Supervised Semi-Supervised Learning](https://arxiv.org/abs/1905.03670) |
| Mon, 9/21 | [Big Self-Supervised Models are Strong Semi-Supervised Learners](https://arxiv.org/abs/2006.10029) |
| Wed, 9/23 | [Semi-Supervised Sequence Learning](https://arxiv.org/abs/1511.01432) |
| Mon, 9/28 | [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding](https://arxiv.org/abs/1810.04805) |
| Wed, 9/30 | [ELECTRA: Pre-training Text Encoders as Discriminators Rather Than Generators](https://arxiv.org/abs/2003.10555) |
| Mon, 10/5 | [Multi-Task Deep Neural Networks for Natural Language Understanding](https://arxiv.org/abs/1901.11504) |
| Wed, 10/7 | [Parameter-Efficient Transfer Learning for NLP](https://arxiv.org/abs/1902.00751) |
| Mon, 10/12 | [To Tune or Not to Tune? Adapting Pretrained Representations to Diverse Tasks](https://arxiv.org/abs/1903.05987) |
| Wed, 10/14 | [Fine-Tuning Pretrained Language Models: Weight Initializations, Data Orders, and Early Stopping](https://arxiv.org/abs/2002.06305) |
| Mon, 10/19 | Project proposals due, [How transferable are features in deep neural networks?](https://arxiv.org/abs/1411.1792) |
| Wed, 10/21 | [Do Better ImageNet Models Transfer Better?](https://arxiv.org/abs/1805.08974) |
| Mon, 10/26 | [Exploring the Limits of Weakly Supervised Pretraining](https://arxiv.org/abs/1805.00932) |
| Wed, 10/28 | [A Simple Framework for Contrastive Learning of Visual Representations](https://arxiv.org/abs/2002.05709) |
| Mon, 11/2 | [Unsupervised Learning of Visual Features by Contrasting Cluster Assignments](https://arxiv.org/abs/2006.09882) |
| Wed, 11/4 | [Rethinking ImageNet Pre-Training](https://arxiv.org/abs/1811.08883) |
| Mon, 11/9 | [Task2Vec: Task Embedding for Meta-Learning](https://arxiv.org/abs/1902.03545) |
| Wed, 11/11 | Guest lecture |
| Mon, 11/16 | Guest lecture |
| Final exam slot | Final project presentations |

## Grading

  1. **Readings**, 60 points: There will be 24 papers, and each student will be in the presenting role for 12 and the non-presenting role for the other 12. You can earn up to 4 points each time you present for completing the assignment for your role and presenting it to the class. When you aren't presenting, you can earn up to 1 point by completing the non-presenting assignment and by participating in the class through live discussion and questions.
  1. **Final Project**, 40 points: This grade will be divided into the following categories:
      - Proposal: 5 points.
      - Novelty: 5 points; your project should propose something new (either a new application, method, or perspective).
      - Writing: 10 points; your paper should be readable and complete and situate its self appropriately among related work. You should use the format and style of a standard machine learning conference paper.
      - Presentation: 10 points; your final project presentation should be clear and provide a solid picture of what you did.
      - Code: 10 points; the code you write and submit for your final project should allow for complete reproduction of your results and be well-documented.

## Attendance, late work, and the honor code

If you miss a class without completing the corresponding assignment, you'll get a zero for that session.
If you miss a class where you are in a "presenting" role for that session, you must still create the presentation for that role before the class and you must find someone else to present it for you.
If you miss a class where you'd be in a "non-presenting" role, to get credit for that session you need to complete the non-presenting assignment and send it to me before the start of class.
There's really no way to accept late work for the readings since it's vital that we're all reading the same papers at the same time.
I also can't accept the final project after the scheduled final exam slot since you need to present it then.

All students are expected to follow the guidelines of the [UNC honor code](http://honor.unc.edu).
In the context of this class, it is particularly important that you cite the source of different ideas, facts, or methods and do not claim someone else's work as your own.
If you are unsure about which actions violate that honor code, feel free to ask me.

## Conduct

I ask that we all follow the [NeurIPS Code of Conduct](https://nips.cc/public/CodeOfConduct) and the [Recurse Center Social Rules](https://www.recurse.com/social-rules).
Since this is a discussion class, it's especially important that we respect everyone's perspective and input.
In particular, I value the perspectives of individuals from all backgrounds reflecting the diversity of our students.
I broadly define diversity to include race, gender identity, national origin, ethnicity, religion, social class, age, sexual orientation, political background, and physical and learning ability.
I will strive to make this classroom an inclusive space for all students.
Please let me know if there is anything I can do to improve.

Acts of discrimination, harassment, interpersonal (relationship) violence, sexual violence, sexual exploitation, stalking, and related retaliation are prohibited at UNC-Chapel Hill.
If you have experienced these types of conduct, you are encouraged to report the incident and seek resources on campus or in the community.
Please contact the Director of Title IX Compliance/Title IX Coordinator (Adrienne Allison, adrienne.allison@unc.edu), Report and Response Coordinators (Ew Quimbaya-Winship, eqw@unc.edu; Rebecca Gibson, rmgibson@unc.edu; Kathryn Winn kmwinn@unc.edu), Counseling and Psychological Services (CAPs) (confidential) in Campus Health Services at (919) 966-3658, or the Gender Violence Services Coordinators (confidential) (Cassidy Johnson, cassidyjohnson@unc.edu; Holly Lovern, holly.lovern@unc.edu) to discuss your specific needs.
Additional resources are available at http://safe.unc.edu.

## Resources

The University of North Carolina at Chapel Hill facilitates the implementation of reasonable accommodations, including resources and services, for students with disabilities, chronic medical conditions, a temporary disability or pregnancy complications resulting in difficulties with accessing learning opportunities.
All accommodations are coordinated through the Accessibility Resources and Service Office. See the ARS Website for contact information: https://ars.unc.edu or email ars@unc.edu.
Relevant policy documents as they relate to registration and accommodations determinations and the student registration form are available on the ARS website under the About ARS tab.

CAPS is strongly committed to addressing the mental health needs of a diverse student body through timely access to consultation and connection to clinically appropriate services, whether for short or long-term needs. Go to their [website](https://caps.unc.edu/) or visit their facilities on the third floor of the Campus Health Services building for a walk-in evaluation to learn more.

## Changes

I reserve the right to make changes to the syllabus, including project due dates and test dates.
These changes will be announced as early as possible.

