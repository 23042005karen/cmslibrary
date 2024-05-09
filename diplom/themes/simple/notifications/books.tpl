<table width="100%" cellpadding="0" cellspacing="0" class="table-bordered" border="1">
    <thead>
        <tr>
            <th>Book</th>
        </tr>
    </thead>
    <tbody>
        {foreach $books as $book}
            <tr>
                <td>
                    <a href="{$SiteURL}{$routes->getRouteString("bookViewPublic",["bookId"=>$book->getId()])}">{$book->getTitle()}</a>
                </td>
            </tr>
        {/foreach}
    </tbody>
</table>