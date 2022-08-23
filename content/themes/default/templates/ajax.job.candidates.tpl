<div class="modal-header">
  <h6 class="modal-title">
    <i class="fas fa-briefcase mr5"></i>{__("Job Candidates")}
  </h6>
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<div class="modal-body">
  {if $candidates}
    <ul>
      {foreach $candidates as $candidate}
        {include file='__feeds_candidate.tpl'}
      {/foreach}
    </ul>

    {if $candidates_count >= $system['max_results']}
      <!-- see-more -->
      <div class="alert alert-info see-more js_see-more" data-get="job_candidates" data-id="{$post_id}">
        <span>{__("See More")}</span>
        <div class="loader loader_small x-hidden"></div>
      </div>
      <!-- see-more -->
    {/if}
  {else}
    {include file='_no_data.tpl'}
  {/if}
</div>